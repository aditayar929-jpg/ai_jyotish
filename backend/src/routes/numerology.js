const express = require('express');
const { auth } = require('../middleware/auth');
const { NumerologyEngine } = require('../services/aiAstrologyEngine');

const router = express.Router();
const numerologyEngine = new NumerologyEngine();

// Calculate Numerology
router.post('/calculate', auth, async (req, res) => {
  try {
    const { name, dateOfBirth } = req.body;

    const lifePathNumber = numerologyEngine.calculateLifePathNumber(dateOfBirth);
    const destinyNumber = numerologyEngine.calculateDestinyNumber(name);
    const soulNumber = numerologyEngine.calculateSoulNumber(name);
    const personalityNumber = numerologyEngine.calculateDestinyNumber(name.split(' ')[0]);

    const result = {
      name,
      dateOfBirth,
      lifePathNumber,
      destinyNumber,
      soulNumber,
      personalityNumber,
      lifePathMeaning: numerologyEngine.getNumberMeaning(lifePathNumber),
      destinyMeaning: numerologyEngine.getNumberMeaning(destinyNumber),
      soulMeaning: numerologyEngine.getNumberMeaning(soulNumber),
      personalityMeaning: numerologyEngine.getNumberMeaning(personalityNumber),
      luckyNumbers: getLuckyNumbers(lifePathNumber),
      luckyColor: getLuckyColor(lifePathNumber),
      luckyDay: getLuckyDay(lifePathNumber),
      luckyGemstone: getLuckyGemstone(lifePathNumber),
    };

    res.json({ success: true, data: { numerology: result } });
  } catch (error) {
    res.status(500).json({ success: false, message: error.message });
  }
});

function getLuckyNumbers(number) {
  const map = {
    1: [1, 10, 19, 28], 2: [2, 11, 20, 29], 3: [3, 12, 21, 30],
    4: [4, 13, 22, 31], 5: [5, 14, 23], 6: [6, 15, 24],
    7: [7, 16, 25], 8: [8, 17, 26], 9: [9, 18, 27],
    11: [11, 29], 22: [22, 31], 33: [33],
  };
  return (map[number] || [number]).map(String);
}

function getLuckyColor(number) {
  const map = { 1: 'Gold', 2: 'Silver', 3: 'Yellow', 4: 'Blue', 5: 'Green', 6: 'Pink', 7: 'Purple', 8: 'Black', 9: 'Red', 11: 'White', 22: 'Royal Blue', 33: 'Violet' };
  return map[number] || 'Gold';
}

function getLuckyDay(number) {
  const map = { 1: 'Sunday', 2: 'Monday', 3: 'Thursday', 4: 'Sunday', 5: 'Wednesday', 6: 'Friday', 7: 'Monday', 8: 'Saturday', 9: 'Tuesday' };
  return map[number] || 'Thursday';
}

function getLuckyGemstone(number) {
  const map = { 1: 'Ruby', 2: 'Pearl', 3: 'Yellow Sapphire', 4: 'Emerald', 5: 'Diamond', 6: 'White Sapphire', 7: 'Cat Eye', 8: 'Blue Sapphire', 9: 'Red Coral' };
  return map[number] || 'Yellow Sapphire';
}

module.exports = router;
