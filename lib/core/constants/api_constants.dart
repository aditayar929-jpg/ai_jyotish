class ApiConstants {
  static const String baseUrl = 'https://api.aijyotish.com';
  static const String apiVersion = '/v1';

  // Auth
  static const String login = '$apiVersion/auth/login';
  static const String register = '$apiVersion/auth/register';
  static const String sendOtp = '$apiVersion/auth/send-otp';
  static const String verifyOtp = '$apiVersion/auth/verify-otp';
  static const String refreshToken = '$apiVersion/auth/refresh';

  // Kundli
  static const String generateKundli = '$apiVersion/kundli/generate';
  static const String kundliHistory = '$apiVersion/kundli/history';
  static const String kundliDetails = '$apiVersion/kundli/details';

  // Horoscope
  static const String dailyHoroscope = '$apiVersion/horoscope/daily';
  static const String weeklyHoroscope = '$apiVersion/horoscope/weekly';
  static const String monthlyHoroscope = '$apiVersion/horoscope/monthly';
  static const String yearlyHoroscope = '$apiVersion/horoscope/yearly';

  // AI
  static const String aiChat = '$apiVersion/ai/chat';
  static const String aiPrediction = '$apiVersion/ai/predict';
  static const String aiPalmReading = '$apiVersion/ai/palm-reading';
  static const String aiFaceReading = '$apiVersion/ai/face-reading';

  // Numerology
  static const String numerology = '$apiVersion/numerology/calculate';

  // Wallet
  static const String walletBalance = '$apiVersion/wallet/balance';
  static const String walletRecharge = '$apiVersion/wallet/recharge';
  static const String walletHistory = '$apiVersion/wallet/history';

  // Astrologers
  static const String astrologers = '$apiVersion/astrologers';
  static const String bookConsultation = '$apiVersion/consultations/book';

  // Subscription
  static const String plans = '$apiVersion/subscriptions/plans';
  static const String subscribe = '$apiVersion/subscriptions/subscribe';

  // User
  static const String userProfile = '$apiVersion/user/profile';
  static const String updateProfile = '$apiVersion/user/update';

  // External APIs
  static const String astrologyApiBase = 'https://api.astrologyapi.com/v1';
  static const String openaiBase = 'https://api.openai.com/v1';
  static const String geminiBase = 'https://generativelanguage.googleapis.com/v1beta';
}
