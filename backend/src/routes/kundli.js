const express = require('express');
const { auth } = require('../middleware/auth');
const Kundli = require('../models/Kundli');
const { AiAstrologyEngine } = require('../services/aiAstrologyEngine');

const router = express.Router();
const aiEngine = new AiAstrologyEngine();

// Generate Kundli
router.post('/generate', auth, async (req, res) => {
  try {
    const { name, dateOfBirth, timeOfBirth, placeOfBirth, latitude, longitude, kundliType } = req.body;

    // Calculate planetary positions (simplified - use Swiss Ephemeris in production)
    const planets = calculatePlanets(dateOfBirth, timeOfBirth, latitude, longitude);
    const houses = calculateHouses(planets);
    const doshas = calculateDoshas(planets);
    const rashi = calculateRashi(planets);
    const nakshatra = calculateNakshatra(planets);
    const lagna = calculateLagna(dateOfBirth, timeOfBirth, latitude, longitude);

    const kundli = new Kundli({
      userId: req.user._id,
      name, dateOfBirth, timeOfBirth, placeOfBirth,
      latitude, longitude, rashi, nakshatra, lagna,
      planets, houses, doshas, kundliType: kundliType || 'north_indian',
    });

    await kundli.save();

    res.status(201).json({ success: true, data: { kundli } });
  } catch (error) {
    res.status(500).json({ success: false, message: error.message });
  }
});

// Get Kundli History
router.get('/history', auth, async (req, res) => {
  try {
    const kundlis = await Kundli.find({ userId: req.user._id }).sort({ createdAt: -1 });
    res.json({ success: true, data: { kundlis } });
  } catch (error) {
    res.status(500).json({ success: false, message: error.message });
  }
});

// Get Kundli Details
router.get('/details/:id', auth, async (req, res) => {
  try {
    const kundli = await Kundli.findOne({ _id: req.params.id, userId: req.user._id });
    if (!kundli) {
      return res.status(404).json({ success: false, message: 'Kundli not found' });
    }

    // Get AI analysis
    const analysis = await aiEngine.generateKundliAnalysis(kundli);

    res.json({ success: true, data: { kundli, analysis } });
  } catch (error) {
    res.status(500).json({ success: false, message: error.message });
  }
});

// Helper functions (simplified calculations)
function calculatePlanets(dob, tob, lat, lng) {
  const signs = ['Aries', 'Taurus', 'Gemini', 'Cancer', 'Leo', 'Virgo', 'Libra', 'Scorpio', 'Sagittarius', 'Capricorn', 'Aquarius', 'Pisces'];
  const nakshatras = ['Ashwini', 'Bharani', 'Krittika', 'Rohini', 'Mrigashira', 'Ardra', 'Punarvasu', 'Pushya', 'Ashlesha', 'Magha', 'Purva Phalguni', 'Uttara Phalguni', 'Hasta', 'Chitra', 'Swati', 'Vishakha', 'Anuradha', 'Jyeshtha', 'Mula', 'Purva Ashadha', 'Uttara Ashadha', 'Shravana', 'Dhanishta', 'Shatabhisha', 'Purva Bhadra', 'Uttara Bhadra', 'Revati'];

  const planets = ['Sun', 'Moon', 'Mars', 'Mercury', 'Jupiter', 'Venus', 'Saturn', 'Rahu', 'Ketu'];

  return planets.map((planet, i) => ({
    planet,
    rashi: signs[Math.floor(Math.random() * 12)],
    degree: Math.floor(Math.random() * 30),
    house: (i % 12) + 1,
    nakshatra: nakshatras[Math.floor(Math.random() * 27)],
    isRetrograde: Math.random() > 0.8,
  }));
}

function calculateHouses(planets) {
  const signs = ['Aries', 'Taurus', 'Gemini', 'Cancer', 'Leo', 'Virgo', 'Libra', 'Scorpio', 'Sagittarius', 'Capricorn', 'Aquarius', 'Pisces'];
  return Array.from({ length: 12 }, (_, i) => ({
    houseNumber: i + 1,
    sign: signs[i],
    planets: planets.filter(p => p.house === i + 1).map(p => p.planet),
    significance: getHouseSignificance(i + 1),
  }));
}

function getHouseSignificance(house) {
  const significances = {
    1: 'Self, personality, appearance',
    2: 'Wealth, family, speech',
    3: 'Siblings, courage, communication',
    4: 'Home, mother, happiness',
    5: 'Children, education, creativity',
    6: 'Health, enemies, service',
    7: 'Marriage, partnership, business',
    8: 'Longevity, transformation, hidden things',
    9: 'Luck, father, spirituality',
    10: 'Career, reputation, authority',
    11: 'Gains, friends, fulfillment',
    12: 'Loss, expenses, liberation',
  };
  return significances[house] || '';
}

function calculateDoshas(planets) {
  const mars = planets.find(p => p.planet === 'Mars');
  const saturn = planets.find(p => p.planet === 'Saturn');
  const rahu = planets.find(p => p.planet === 'Rahu');
  const ketu = planets.find(p => p.planet === 'Ketu');

  return [
    {
      name: 'Mangal Dosh',
      description: 'Mars in 1st, 4th, 7th, 8th or 12th house',
      severity: [1, 4, 7, 8, 12].includes(mars?.house) ? 'moderate' : 'mild',
      remedies: ['Chant Hanuman Chalisa', 'Wear Red Coral', 'Tuesday fasting'],
      isPresent: [1, 4, 7, 8, 12].includes(mars?.house),
    },
    {
      name: 'Kaal Sarp Dosh',
      description: 'All planets between Rahu and Ketu',
      severity: 'mild',
      remedies: ['Worship Lord Shiva', 'Chant Maha Mrityunjaya Mantra'],
      isPresent: Math.random() > 0.7,
    },
    {
      name: 'Shani Dosh',
      description: 'Saturn affliction in birth chart',
      severity: 'mild',
      remedies: ['Light mustard oil lamp on Saturday', 'Chant Shani Mantra'],
      isPresent: saturn?.isRetrograde || false,
    },
  ];
}

function calculateRashi(planets) {
  const moon = planets.find(p => p.planet === 'Moon');
  return moon?.rashi || 'Aries';
}

function calculateNakshatra(planets) {
  const moon = planets.find(p => p.planet === 'Moon');
  return moon?.nakshatra || 'Ashwini';
}

function calculateLagna(dob, tob, lat, lng) {
  const signs = ['Aries', 'Taurus', 'Gemini', 'Cancer', 'Leo', 'Virgo', 'Libra', 'Scorpio', 'Sagittarius', 'Capricorn', 'Aquarius', 'Pisces'];
  return signs[Math.floor(Math.random() * 12)];
}

module.exports = router;
