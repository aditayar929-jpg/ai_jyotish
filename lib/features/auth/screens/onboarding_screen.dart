import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/theme/cosmic_theme.dart';
import '../../../core/widgets/cosmic_background.dart';
import '../../../core/widgets/cosmic_button.dart';
import '../../../core/storage/local_storage.dart';
import '../../../core/di/service_locator.dart';

class OnboardingScreen extends ConsumerStatefulWidget {
  const OnboardingScreen({super.key});

  @override
  ConsumerState<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends ConsumerState<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<_OnboardingData> _pages = [
    _OnboardingData(
      icon: '🌌',
      title: 'Discover Your Cosmic Path',
      subtitle: 'AI-powered astrology that reads the stars to guide your journey through life',
      gradient: [CosmicTheme.nebulaPurple, CosmicTheme.cosmicBlue],
    ),
    _OnboardingData(
      icon: '🔮',
      title: 'AI Kundli & Predictions',
      subtitle: 'Generate detailed kundli, get future predictions powered by advanced AI algorithms',
      gradient: [CosmicTheme.celestialTeal, CosmicTheme.nebulaPurple],
    ),
    _OnboardingData(
      icon: '✨',
      title: 'Your Personal AI Astrologer',
      subtitle: 'Chat with AI astrologer, get daily horoscope, numerology, palm reading & more',
      gradient: [CosmicTheme.stardustGold, CosmicTheme.solarOrange],
    ),
  ];

  void _nextPage() {
    if (_currentPage < _pages.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );
    } else {
      _completeOnboarding();
    }
  }

  void _completeOnboarding() async {
    final storage = getIt<LocalStorage>();
    await storage.setFirstLaunchDone();
    if (mounted) context.go('/auth/login');
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CosmicBackground(
        child: SafeArea(
          child: Column(
            children: [
              // Skip button
              Align(
                alignment: Alignment.topRight,
                child: TextButton(
                  onPressed: _completeOnboarding,
                  child: Text(
                    'Skip',
                    style: GoogleFonts.poppins(
                      color: CosmicTheme.textSecondary,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
              // Page View
              Expanded(
                child: PageView.builder(
                  controller: _pageController,
                  onPageChanged: (index) {
                    setState(() => _currentPage = index);
                  },
                  itemCount: _pages.length,
                  itemBuilder: (context, index) {
                    final page = _pages[index];
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 32),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // Icon
                          Container(
                            width: 160,
                            height: 160,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              gradient: RadialGradient(
                                colors: [
                                  page.gradient[0].withOpacity(0.3),
                                  page.gradient[1].withOpacity(0.1),
                                  Colors.transparent,
                                ],
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: page.gradient[0].withOpacity(0.3),
                                  blurRadius: 40,
                                  spreadRadius: 5,
                                ),
                              ],
                            ),
                            child: Center(
                              child: Text(
                                page.icon,
                                style: const TextStyle(fontSize: 80),
                              ),
                            ),
                          ),
                          const SizedBox(height: 50),
                          // Title
                          Text(
                            page.title,
                            textAlign: TextAlign.center,
                            style: GoogleFonts.orbitron(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: CosmicTheme.textPrimary,
                              height: 1.3,
                            ),
                          ),
                          const SizedBox(height: 20),
                          // Subtitle
                          Text(
                            page.subtitle,
                            textAlign: TextAlign.center,
                            style: GoogleFonts.poppins(
                              fontSize: 16,
                              color: CosmicTheme.textSecondary,
                              height: 1.5,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
              // Dots
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  _pages.length,
                  (index) => AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    width: _currentPage == index ? 32 : 8,
                    height: 8,
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      gradient: _currentPage == index
                          ? CosmicTheme.goldGradient
                          : null,
                      color: _currentPage == index
                          ? null
                          : CosmicTheme.textMuted.withOpacity(0.3),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 40),
              // Button
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32),
                child: CosmicButton(
                  text: _currentPage == _pages.length - 1
                      ? 'Get Started'
                      : 'Next',
                  icon: _currentPage == _pages.length - 1
                      ? Icons.rocket_launch
                      : Icons.arrow_forward,
                  onPressed: _nextPage,
                ),
              ),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}

class _OnboardingData {
  final String icon;
  final String title;
  final String subtitle;
  final List<Color> gradient;

  const _OnboardingData({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.gradient,
  });
}
