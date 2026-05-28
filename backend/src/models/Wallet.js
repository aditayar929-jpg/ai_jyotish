const mongoose = require('mongoose');

const transactionSchema = new mongoose.Schema({
  userId: { type: mongoose.Schema.Types.ObjectId, ref: 'User', required: true },
  type: { type: String, enum: ['credit', 'debit'], required: true },
  amount: { type: Number, required: true },
  description: { type: String, required: true },
  category: { type: String, enum: ['recharge', 'consultation', 'ai_chat', 'prediction', 'palm_reading', 'referral', 'subscription', 'bonus'] },
  referenceId: { type: String },
  paymentMethod: { type: String, enum: ['razorpay', 'upi', 'paytm', 'card', 'coins'] },
  paymentId: { type: String },
  status: { type: String, enum: ['pending', 'completed', 'failed', 'refunded'], default: 'pending' },
}, { timestamps: true });

transactionSchema.index({ userId: 1, createdAt: -1 });

module.exports = mongoose.model('Transaction', transactionSchema);
