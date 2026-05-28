const express = require('express');
const Horoscope = require('../models/Horoscope');
const { AiAstrologyEngine } = require('../services/aiAstrologyEngine');

const router = express.Router();
const aiEngine = new AiAstrologyEngine();

// Get Daily Horoscope
router.get('/daily/:zodiacSign', async (req, res) => {
  try {
    const { zodiacSign } = req.params;
    const today = new Date().toISOString().split('T')[0];

    let horoscope = await Horoscope.findOne({ zodiacSign, date: today, period: 'daily' });

    if (!horoscope) {
      // Generate with AI
      const data = await aiEngine.generateHoroscope(zodiacSign, 'daily');
      horoscope = new Horoscope({ ...data, zodiacSign, date: today, period: 'daily' });
      await horoscope.save();
    }

    res.json({ success: true, data: { horoscope } });
  } catch (error) {
    res.status(500).json({ success: false, message: error.message });
  }
});

// Get Weekly Horoscope
router.get('/weekly/:zodiacSign', async (req, res) => {
  try {
    const { zodiacSign } = req.params;
    const data = await aiEngine.generateHoroscope(zodiacSign, 'weekly');
    res.json({ success: true, data: { horoscope: data } });
  } catch (error) {
    res.status(500).json({ success: false, message: error.message });
  }
});

// Get Monthly Horoscope
router.get('/monthly/:zodiacSign', async (req, res) => {
  try {
    const { zodiacSign } = req.params;
    const data = await aiEngine.generateHoroscope(zodiacSign, 'monthly');
    res.json({ success: true, data: { horoscope: data } });
  } catch (error) {
    res.status(500).json({ success: false, message: error.message });
  }
});

// Get Yearly Horoscope
router.get('/yearly/:zodiacSign', async (req, res) => {
  try {
    const { zodiacSign } = req.params;
    const data = await aiEngine.generateHoroscope(zodiacSign, 'yearly');
    res.json({ success: true, data: { horoscope: data } });
  } catch (error) {
    res.status(500).json({ success: false, message: error.message });
  }
});

module.exports = router;
