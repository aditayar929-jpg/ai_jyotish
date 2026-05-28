const express = require('express');
const Razorpay = require('razorpay');
const { auth } = require('../middleware/auth');
const User = require('../models/User');

const router = express.Router();

const razorpay = new Razorpay({
  key_id: process.env.RAZORPAY_KEY_ID,
  key_secret: process.env.RAZORPAY_KEY_SECRET,
});

const plans = [
  { id: 'monthly', name: 'Monthly', price: 299, duration: 30, features: ['Unlimited AI Chat', 'Detailed Kundli', 'Premium Predictions', 'Ad-free'] },
  { id: 'quarterly', name: 'Quarterly', price: 699, duration: 90, features: ['Everything in Monthly', 'Priority Support', 'Exclusive Reports'] },
  { id: 'yearly', name: 'Yearly', price: 1999, duration: 365, features: ['Everything in Quarterly', 'Personal Astrologer', 'Live Sessions'] },
];

// Get Plans
router.get('/plans', (req, res) => {
  res.json({ success: true, data: { plans } });
});

// Subscribe
router.post('/subscribe', auth, async (req, res) => {
  try {
    const { planId } = req.body;
    const plan = plans.find(p => p.id === planId);

    if (!plan) {
      return res.status(404).json({ success: false, message: 'Plan not found' });
    }

    const order = await razorpay.orders.create({
      amount: plan.price * 100,
      currency: 'INR',
      receipt: `sub_${Date.now()}`,
    });

    res.json({
      success: true,
      data: { orderId: order.id, amount: order.amount, plan },
    });
  } catch (error) {
    res.status(500).json({ success: false, message: error.message });
  }
});

// Verify Subscription
router.post('/verify', auth, async (req, res) => {
  try {
    const { orderId, paymentId, signature, planId } = req.body;
    const plan = plans.find(p => p.id === planId);

    // Verify payment
    const crypto = require('crypto');
    const expectedSignature = crypto
      .createHmac('sha256', process.env.RAZORPAY_KEY_SECRET)
      .update(`${orderId}|${paymentId}`)
      .digest('hex');

    if (expectedSignature !== signature) {
      return res.status(400).json({ success: false, message: 'Invalid payment' });
    }

    // Update user to premium
    const expiryDate = new Date();
    expiryDate.setDate(expiryDate.getDate() + plan.duration);

    await User.findByIdAndUpdate(req.user._id, {
      isPremium: true,
      premiumExpiry: expiryDate,
    });

    res.json({ success: true, message: 'Subscription activated successfully' });
  } catch (error) {
    res.status(500).json({ success: false, message: error.message });
  }
});

// Get Subscription Status
router.get('/status', auth, async (req, res) => {
  try {
    const user = await User.findById(req.user._id).select('isPremium premiumExpiry');
    res.json({
      success: true,
      data: {
        isPremium: user.isPremium,
        expiryDate: user.premiumExpiry,
        isActive: user.isPremium && user.premiumExpiry > new Date(),
      },
    });
  } catch (error) {
    res.status(500).json({ success: false, message: error.message });
  }
});

module.exports = router;
