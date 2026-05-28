class AppAssets {
  static const String _images = 'assets/images';
  static const String _animations = 'assets/animations';
  static const String _icons = 'assets/icons';
  static const String _zodiac = 'assets/zodiac';
  static const String _tarot = 'assets/tarot';

  // Images
  static const String splashLogo = '$_images/splash_logo.png';
  static const String appIcon = '$_images/app_icon.png';
  static const String galaxyBg = '$_images/galaxy_bg.png';
  static const String cosmicBg = '$_images/cosmic_bg.png';
  static const String onboarding1 = '$_images/onboarding_1.png';
  static const String onboarding2 = '$_images/onboarding_2.png';
  static const String onboarding3 = '$_images/onboarding_3.png';
  static const String palmSample = '$_images/palm_sample.png';
  static const String faceSample = '$_images/face_sample.png';

  // Animations
  static const String splashAnim = '$_animations/splash.json';
  static const String starsAnim = '$_animations/stars.json';
  static const String zodiacWheelAnim = '$_animations/zodiac_wheel.json';
  static const String loadingAnim = '$_animations/loading.json';
  static const String chatAnim = '$_animations/chat.json';
  static const String predictionAnim = '$_animations/prediction.json';
  static const String palmAnim = '$_animations/palm.json';
  static const String walletAnim = '$_animations/wallet.json';
  static const String successAnim = '$_animations/success.json';
  static const String errorAnim = '$_animations/error.json';

  // Zodiac Icons
  static String zodiacIcon(String sign) => '$_zodiac/${sign.toLowerCase()}.svg';

  // Tarot Cards
  static String tarotCard(int index) => '$_tarot/card_$index.png';
}
