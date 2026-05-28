const mongoose = require('mongoose');

const horoscopeSchema = new mongoose.Schema({
  zodiacSign: { type: String, required: true, enum: ['Aries', 'Taurus', 'Gemini', 'Cancer', 'Leo', 'Virgo', 'Libra', 'Scorpio', 'Sagittarius', 'Capricorn', 'Aquarius', 'Pisces'] },
  date: { type: String, required: true },
  period: { type: String, enum: ['daily', 'weekly', 'monthly', 'yearly'], required: true },
  summary: { type: String, required: true },
  love: { type: String },
  career: { type: String },
  health: { type: String },
  finance: { type: String },
  spiritual: { type: String },
  luckyNumber: { type: Number },
  luckyColor: { type: String },
  luckyTime: { type: String },
  compatibility: { type: String },
  rating: { type: Number, min: 1, max: 5 },
  keywords: [String],
}, { timestamps: true });

horoscopeSchema.index({ zodiacSign: 1, date: 1, period: 1 }, { unique: true });

module.exports = mongoose.model('Horoscope', horoscopeSchema);
