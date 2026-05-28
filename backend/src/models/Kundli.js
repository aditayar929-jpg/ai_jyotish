const mongoose = require('mongoose');

const planetPositionSchema = new mongoose.Schema({
  planet: { type: String, required: true },
  rashi: { type: String, required: true },
  degree: { type: Number, required: true },
  house: { type: Number, required: true },
  nakshatra: { type: String },
  isRetrograde: { type: Boolean, default: false },
});

const houseSchema = new mongoose.Schema({
  houseNumber: { type: Number, required: true },
  sign: { type: String, required: true },
  planets: [String],
  significance: { type: String },
});

const doshaSchema = new mongoose.Schema({
  name: { type: String, required: true },
  description: { type: String },
  severity: { type: String, enum: ['mild', 'moderate', 'severe'] },
  remedies: [String],
  isPresent: { type: Boolean, default: false },
});

const kundliSchema = new mongoose.Schema({
  userId: { type: mongoose.Schema.Types.ObjectId, ref: 'User', required: true },
  name: { type: String, required: true },
  dateOfBirth: { type: Date, required: true },
  timeOfBirth: { type: String, required: true },
  placeOfBirth: { type: String, required: true },
  latitude: { type: Number, required: true },
  longitude: { type: Number, required: true },
  rashi: { type: String },
  nakshatra: { type: String },
  lagna: { type: String },
  planets: [planetPositionSchema],
  houses: [houseSchema],
  doshas: [doshaSchema],
  kundliType: { type: String, enum: ['north_indian', 'south_indian'], default: 'north_indian' },
}, { timestamps: true });

module.exports = mongoose.model('Kundli', kundliSchema);
