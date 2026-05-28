const express = require('express');
const { auth } = require('../middleware/auth');

const router = express.Router();

// Mock astrologers data
const astrologers = [
  { id: '1', name: 'Dr. Sharma', specialty: 'Vedic Astrology', experience: '15 years', rating: 4.9, consultations: 500, pricePerMin: 5, isOnline: true, icon: '🔮' },
  { id: '2', name: 'Priya Ji', specialty: 'Numerology & Tarot', experience: '10 years', rating: 4.8, consultations: 350, pricePerMin: 5, isOnline: true, icon: '✨' },
  { id: '3', name: 'Acharya Verma', specialty: 'Jyotish Shastra', experience: '20 years', rating: 4.9, consultations: 800, pricePerMin: 8, isOnline: false, icon: '📿' },
  { id: '4', name: 'Guru Dev', specialty: 'KP Astrology', experience: '12 years', rating: 4.7, consultations: 280, pricePerMin: 5, isOnline: true, icon: '🌟' },
  { id: '5', name: 'Dr. Patel', specialty: 'Western Astrology', experience: '8 years', rating: 4.6, consultations: 200, pricePerMin: 4, isOnline: false, icon: '⭐' },
  { id: '6', name: 'Swami Ji', specialty: 'Spiritual Guide', experience: '25 years', rating: 5.0, consultations: 1200, pricePerMin: 10, isOnline: true, icon: '🧘' },
];

// Get All Astrologers
router.get('/', auth, async (req, res) => {
  try {
    const { specialty, isOnline } = req.query;
    let filtered = [...astrologers];

    if (specialty) filtered = filtered.filter(a => a.specialty.toLowerCase().includes(specialty.toLowerCase()));
    if (isOnline === 'true') filtered = filtered.filter(a => a.isOnline);

    res.json({ success: true, data: { astrologers: filtered } });
  } catch (error) {
    res.status(500).json({ success: false, message: error.message });
  }
});

// Get Astrologer Details
router.get('/:id', auth, async (req, res) => {
  try {
    const astrologer = astrologers.find(a => a.id === req.params.id);
    if (!astrologer) {
      return res.status(404).json({ success: false, message: 'Astrologer not found' });
    }
    res.json({ success: true, data: { astrologer } });
  } catch (error) {
    res.status(500).json({ success: false, message: error.message });
  }
});

// Book Consultation
router.post('/book', auth, async (req, res) => {
  try {
    const { astrologerId, type } = req.body;
    const astrologer = astrologers.find(a => a.id === astrologerId);

    if (!astrologer) {
      return res.status(404).json({ success: false, message: 'Astrologer not found' });
    }

    // Create consultation session
    res.json({
      success: true,
      data: {
        sessionId: `session_${Date.now()}`,
        astrologer,
        type,
        pricePerMin: astrologer.pricePerMin,
      },
    });
  } catch (error) {
    res.status(500).json({ success: false, message: error.message });
  }
});

module.exports = router;
