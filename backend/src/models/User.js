const mongoose = require('mongoose');
const bcrypt = require('bcryptjs');

const userSchema = new mongoose.Schema({
  name: { type: String, required: true, trim: true },
  email: { type: String, unique: true, sparse: true, lowercase: true },
  phone: { type: String, unique: true, sparse: true },
  password: { type: String, minlength: 6 },
  photoUrl: { type: String },
  gender: { type: String, enum: ['male', 'female', 'other'] },
  dateOfBirth: { type: Date },
  timeOfBirth: { type: String },
  placeOfBirth: { type: String },
  latitude: { type: Number },
  longitude: { type: Number },
  zodiacSign: { type: String },
  relationshipStatus: { type: String },
  language: { type: String, default: 'en' },
  isPremium: { type: Boolean, default: false },
  premiumExpiry: { type: Date },
  walletCoins: { type: Number, default: 0 },
  referralCode: { type: String, unique: true },
  referredBy: { type: mongoose.Schema.Types.ObjectId, ref: 'User' },
  fcmToken: { type: String },
  authProvider: { type: String, enum: ['email', 'google', 'apple', 'phone'], default: 'email' },
  isActive: { type: Boolean, default: true },
}, { timestamps: true });

userSchema.pre('save', async function(next) {
  if (this.isModified('password') && this.password) {
    this.password = await bcrypt.hash(this.password, 12);
  }
  if (!this.referralCode) {
    this.referralCode = 'AIJ' + Math.random().toString(36).substring(2, 8).toUpperCase();
  }
  next();
});

userSchema.methods.comparePassword = async function(candidatePassword) {
  return bcrypt.compare(candidatePassword, this.password);
};

module.exports = mongoose.model('User', userSchema);
