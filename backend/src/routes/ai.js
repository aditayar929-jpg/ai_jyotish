const express = require('express');
const { auth } = require('../middleware/auth');
const { AiAstrologyEngine } = require('../services/aiAstrologyEngine');
const ChatMessage = require('../models/ChatMessage');
const User = require('../models/User');

const router = express.Router();
const aiEngine = new AiAstrologyEngine();

// AI Chat
router.post('/chat', auth, async (req, res) => {
  try {
    const { message, sessionId } = req.body;
    const user = req.user;

    // Check coins for non-premium users
    if (!user.isPremium && user.walletCoins < 5) {
      return res.status(402).json({ success: false, message: 'Insufficient coins. Please recharge.' });
    }

    const context = {
      zodiacSign: user.zodiacSign,
      dateOfBirth: user.dateOfBirth,
    };

    const result = await aiEngine.getChatResponse(message, context);

    // Save chat message
    await ChatMessage.create({
      userId: user._id,
      sessionId: sessionId || 'default',
      message,
      response: result.response,
      isUser: true,
      tokensUsed: result.tokensUsed,
    });

    // Deduct coins for non-premium users
    if (!user.isPremium) {
      await User.findByIdAndUpdate(user._id, { $inc: { walletCoins: -5 } });
    }

    res.json({
      success: true,
      data: { response: result.response, tokensUsed: result.tokensUsed },
    });
  } catch (error) {
    res.status(500).json({ success: false, message: error.message });
  }
});

// AI Prediction
router.post('/predict', auth, async (req, res) => {
  try {
    const { category } = req.body;
    const user = req.user;

    if (!user.isPremium && user.walletCoins < 10) {
      return res.status(402).json({ success: false, message: 'Insufficient coins' });
    }

    const prediction = await aiEngine.generatePrediction(
      {
        name: user.name,
        dateOfBirth: user.dateOfBirth,
        timeOfBirth: user.timeOfBirth,
        placeOfBirth: user.placeOfBirth,
        zodiacSign: user.zodiacSign,
      },
      category
    );

    if (!user.isPremium) {
      await User.findByIdAndUpdate(user._id, { $inc: { walletCoins: -10 } });
    }

    res.json({ success: true, data: { prediction } });
  } catch (error) {
    res.status(500).json({ success: false, message: error.message });
  }
});

// Palm Reading
router.post('/palm-reading', auth, async (req, res) => {
  try {
    const { imageUrl } = req.body;
    const user = req.user;

    if (!user.isPremium && user.walletCoins < 15) {
      return res.status(402).json({ success: false, message: 'Insufficient coins' });
    }

    const analysis = await aiEngine.analyzePalm(imageUrl);

    if (!user.isPremium) {
      await User.findByIdAndUpdate(user._id, { $inc: { walletCoins: -15 } });
    }

    res.json({ success: true, data: { analysis } });
  } catch (error) {
    res.status(500).json({ success: false, message: error.message });
  }
});

// Face Reading
router.post('/face-reading', auth, async (req, res) => {
  try {
    const { imageUrl } = req.body;
    const user = req.user;

    if (!user.isPremium && user.walletCoins < 15) {
      return res.status(402).json({ success: false, message: 'Insufficient coins' });
    }

    const analysis = await aiEngine.analyzeFace(imageUrl);

    if (!user.isPremium) {
      await User.findByIdAndUpdate(user._id, { $inc: { walletCoins: -15 } });
    }

    res.json({ success: true, data: { analysis } });
  } catch (error) {
    res.status(500).json({ success: false, message: error.message });
  }
});

// Get chat history
router.get('/chat-history', auth, async (req, res) => {
  try {
    const messages = await ChatMessage.find({ userId: req.user._id })
      .sort({ createdAt: -1 })
      .limit(50);

    res.json({ success: true, data: { messages } });
  } catch (error) {
    res.status(500).json({ success: false, message: error.message });
  }
});

module.exports = router;
