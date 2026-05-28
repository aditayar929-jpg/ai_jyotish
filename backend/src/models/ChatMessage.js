const mongoose = require('mongoose');

const chatMessageSchema = new mongoose.Schema({
  userId: { type: mongoose.Schema.Types.ObjectId, ref: 'User', required: true },
  sessionId: { type: String, required: true },
  message: { type: String, required: true },
  response: { type: String },
  isUser: { type: Boolean, required: true },
  category: { type: String, enum: ['career', 'marriage', 'health', 'finance', 'education', 'spiritual', 'general'] },
  mood: { type: String },
  suggestions: [String],
  tokensUsed: { type: Number, default: 0 },
}, { timestamps: true });

chatMessageSchema.index({ userId: 1, sessionId: 1 });

module.exports = mongoose.model('ChatMessage', chatMessageSchema);
