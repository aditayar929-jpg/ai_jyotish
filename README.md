# AI Jyotish - Premium AI Astrology App

A premium AI-powered astrology mobile application built with Flutter, featuring advanced prediction systems, AI chat assistant, kundli generation, horoscope engine, numerology, palm reading, and futuristic cosmic UI.

## Features

### Core Features
- **AI Chat Astrologer** - Conversational AI with personalized predictions
- **Kundli Generation** - North Indian & South Indian charts with dosha analysis
- **Daily Horoscope** - Daily, weekly, monthly, yearly for all 12 zodiac signs
- **AI Predictions** - Career, marriage, finance, health, education, spiritual
- **Numerology** - Life path, destiny, soul, personality numbers
- **Palm Reading** - AI-powered palm line analysis
- **Face Reading** - Face astrology with emotion & aura detection
- **Live Astrologer** - Chat, voice, and video consultations

### Premium Features
- Unlimited AI chat
- Detailed kundli with all doshas
- Premium predictions with timeline
- Ad-free experience
- Priority support

### Wallet System
- Coin-based wallet
- Razorpay, UPI, Paytm integration
- Referral rewards
- Transaction history

## Tech Stack

### Frontend (Flutter)
- Flutter 3.16+ with Dart 3.2+
- Riverpod state management
- GoRouter navigation
- Material 3 design
- Cosmic dark theme with glassmorphism

### Backend (Node.js)
- Express.js REST API
- MongoDB with Mongoose
- Firebase Auth
- OpenAI GPT-4 integration
- Razorpay payments
- Socket.IO real-time chat

## Project Structure

```
ai_jyotish/
├── lib/
│   ├── main.dart
│   ├── firebase_options.dart
│   ├── core/
│   │   ├── app.dart
│   │   ├── theme/cosmic_theme.dart
│   │   ├── router/app_router.dart
│   │   ├── constants/
│   │   ├── di/service_locator.dart
│   │   ├── network/dio_client.dart
│   │   ├── storage/local_storage.dart
│   │   └── widgets/
│   └── features/
│       ├── auth/ (screens, models, providers)
│       ├── main/ (shell with bottom nav)
│       ├── home/ (dashboard)
│       ├── horoscope/ (daily/weekly/monthly)
│       ├── kundli/ (chart generation)
│       ├── ai_chat/ (AI astrologer)
│       ├── predictions/ (AI predictions)
│       ├── numerology/ (number analysis)
│       ├── palm_reading/ (palm analysis)
│       ├── face_reading/ (face analysis)
│       ├── live_astrologer/ (consultations)
│       ├── wallet/ (coins & payments)
│       ├── premium/ (subscription)
│       └── profile/ (settings)
├── backend/
│   ├── src/
│   │   ├── server.js
│   │   ├── models/ (User, Kundli, Horoscope, etc.)
│   │   ├── routes/ (auth, ai, kundli, etc.)
│   │   ├── middleware/auth.js
│   │   └── services/aiAstrologyEngine.js
│   └── package.json
└── pubspec.yaml
```

## Setup

### Flutter App
```bash
cd ai_jyotish
flutter pub get
flutter run
```

### Backend
```bash
cd backend
npm install
cp .env.example .env
# Configure .env with your keys
npm run dev
```

### Firebase Setup
1. Create Firebase project
2. Add Android/iOS apps
3. Download config files
4. Update firebase_options.dart

### Required API Keys
- OpenAI API Key (for AI features)
- Razorpay Keys (for payments)
- Firebase Config (for auth)
- Agora Keys (for video calls)

## Design

### Theme
- Deep space dark background (#0A0A2E)
- Nebula purple accents (#6B21A8)
- Stardust gold highlights (#FFD700)
- Glassmorphism cards with blur effects
- Animated stars and zodiac wheel

### Animations
- Twinkling star particles
- Rotating zodiac wheel
- Planet orbit visualization
- Smooth page transitions
- Glow effects on cards

## Database Schema (MongoDB)

### Collections
- **users** - User profiles with birth details
- **kundli** - Generated birth charts
- **horoscope** - Daily/weekly/monthly horoscopes
- **chatmessages** - AI chat history
- **transactions** - Wallet transactions
- **astrologers** - Astrologer profiles

## Security

- Firebase Authentication
- JWT token-based API auth
- Encrypted user data
- Rate limiting on API
- Payment signature verification
- Input validation & sanitization

## License

Proprietary - All rights reserved
