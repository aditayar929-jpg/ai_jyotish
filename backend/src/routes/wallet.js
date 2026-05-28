const express = require('express');
const Razorpay = require('razorpay');
const { auth } = require('../middleware/auth');
const User = require('../models/User');
const Transaction = require('../models/Wallet');

const router = express.Router();

const razorpay = new Razorpay({
  key_id: process.env.RAZORPAY_KEY_ID,
  key_secret: process.env.RAZORPAY_KEY_SECRET,
});

// Get Balance
router.get('/balance', auth, async (req, res) => {
  try {
    const user = await User.findById(req.user._id).select('walletCoins');
    res.json({ success: true, data: { balance: user.walletCoins } });
  } catch (error) {
    res.status(500).json({ success: false, message: error.message });
  }
});

// Create Recharge Order
router.post('/recharge', auth, async (req, res) => {
  try {
    const { amount, coins } = req.body;

    const order = await razorpay.orders.create({
      amount: amount * 100,
      currency: 'INR',
      receipt: `recharge_${Date.now()}`,
    });

    const transaction = new Transaction({
      userId: req.user._id,
      type: 'credit',
      amount: coins,
      description: `Wallet recharge - ${coins} coins`,
      category: 'recharge',
      paymentMethod: 'razorpay',
      status: 'pending',
    });
    await transaction.save();

    res.json({
      success: true,
      data: { orderId: order.id, amount: order.amount, transactionId: transaction._id },
    });
  } catch (error) {
    res.status(500).json({ success: false, message: error.message });
  }
});

// Verify Payment
router.post('/verify-payment', auth, async (req, res) => {
  try {
    const { orderId, paymentId, signature, transactionId } = req.body;

    // Verify Razorpay signature
    const crypto = require('crypto');
    const expectedSignature = crypto
      .createHmac('sha256', process.env.RAZORPAY_KEY_SECRET)
      .update(`${orderId}|${paymentId}`)
      .digest('hex');

    if (expectedSignature !== signature) {
      return res.status(400).json({ success: false, message: 'Invalid payment signature' });
    }

    // Update transaction
    const transaction = await Transaction.findByIdAndUpdate(
      transactionId,
      { status: 'completed', paymentId },
      { new: true }
    );

    // Add coins to wallet
    await User.findByIdAndUpdate(req.user._id, {
      $inc: { walletCoins: transaction.amount },
    });

    res.json({ success: true, message: 'Payment verified successfully' });
  } catch (error) {
    res.status(500).json({ success: false, message: error.message });
  }
});

// Get Transaction History
router.get('/history', auth, async (req, res) => {
  try {
    const transactions = await Transaction.find({ userId: req.user._id })
      .sort({ createdAt: -1 })
      .limit(50);

    res.json({ success: true, data: { transactions } });
  } catch (error) {
    res.status(500).json({ success: false, message: error.message });
  }
});

// Referral Reward
router.post('/referral', auth, async (req, res) => {
  try {
    const { referralCode } = req.body;
    const referrer = await User.findOne({ referralCode });

    if (!referrer) {
      return res.status(404).json({ success: false, message: 'Invalid referral code' });
    }

    // Add bonus to both users
    await User.findByIdAndUpdate(referrer._id, { $inc: { walletCoins: 50 } });
    await User.findByIdAndUpdate(req.user._id, { $inc: { walletCoins: 50 } });

    // Record transactions
    await Transaction.insertMany([
      { userId: referrer._id, type: 'credit', amount: 50, description: 'Referral bonus', category: 'referral', status: 'completed' },
      { userId: req.user._id, type: 'credit', amount: 50, description: 'Referral bonus', category: 'referral', status: 'completed' },
    ]);

    res.json({ success: true, message: 'Referral bonus credited' });
  } catch (error) {
    res.status(500).json({ success: false, message: error.message });
  }
});

module.exports = router;
