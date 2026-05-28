import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../storage/local_storage.dart';
import '../di/service_locator.dart';

// Auth
import '../../features/auth/screens/splash_screen.dart';
import '../../features/auth/screens/onboarding_screen.dart';
import '../../features/auth/screens/login_screen.dart';
import '../../features/auth/screens/register_screen.dart';
import '../../features/auth/screens/otp_screen.dart';
import '../../features/auth/screens/profile_setup_screen.dart';

// Main
import '../../features/main/screens/main_shell.dart';

// Home
import '../../features/home/screens/home_screen.dart';

// Kundli
import '../../features/kundli/screens/kundli_screen.dart';
import '../../features/kundli/screens/kundli_detail_screen.dart';

// Horoscope
import '../../features/horoscope/screens/horoscope_screen.dart';

// AI Chat
import '../../features/ai_chat/screens/ai_chat_screen.dart';

// Predictions
import '../../features/predictions/screens/predictions_screen.dart';

// Numerology
import '../../features/numerology/screens/numerology_screen.dart';

// Palm Reading
import '../../features/palm_reading/screens/palm_reading_screen.dart';

// Face Reading
import '../../features/face_reading/screens/face_reading_screen.dart';

// Live Astrologer
import '../../features/live_astrologer/screens/astrologer_list_screen.dart';
import '../../features/live_astrologer/screens/consultation_screen.dart';

// Wallet
import '../../features/wallet/screens/wallet_screen.dart';

// Profile
import '../../features/profile/screens/profile_screen.dart';
import '../../features/profile/screens/settings_screen.dart';

// Premium
import '../../features/premium/screens/premium_screen.dart';

final appRouterProvider = Provider<GoRouter>((ref) {
  final storage = getIt<LocalStorage>();

  return GoRouter(
    initialLocation: '/splash',
    debugLogDiagnostics: true,
    redirect: (context, state) {
      final isLoggedIn = storage.isLoggedIn;
      final isFirstLaunch = storage.isFirstLaunch;
      final path = state.matchedLocation;

      if (path == '/splash') return null;

      if (isFirstLaunch && path != '/onboarding') {
        return '/onboarding';
      }

      if (!isLoggedIn && !path.startsWith('/auth')) {
        return '/auth/login';
      }

      return null;
    },
    routes: [
      GoRoute(
        path: '/splash',
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: '/onboarding',
        builder: (context, state) => const OnboardingScreen(),
      ),
      // Auth Routes
      GoRoute(
        path: '/auth/login',
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: '/auth/register',
        builder: (context, state) => const RegisterScreen(),
      ),
      GoRoute(
        path: '/auth/otp',
        builder: (context, state) => OtpScreen(
          phoneNumber: state.extra as String? ?? '',
        ),
      ),
      GoRoute(
        path: '/auth/profile-setup',
        builder: (context, state) => const ProfileSetupScreen(),
      ),
      // Main Shell with Bottom Navigation
      ShellRoute(
        builder: (context, state, child) => MainShell(child: child),
        routes: [
          GoRoute(
            path: '/',
            pageBuilder: (context, state) => const NoTransitionPage(
              child: HomeScreen(),
            ),
          ),
          GoRoute(
            path: '/horoscope',
            pageBuilder: (context, state) => const NoTransitionPage(
              child: HoroscopeScreen(),
            ),
          ),
          GoRoute(
            path: '/kundli',
            pageBuilder: (context, state) => const NoTransitionPage(
              child: KundliScreen(),
            ),
          ),
          GoRoute(
            path: '/profile',
            pageBuilder: (context, state) => const NoTransitionPage(
              child: ProfileScreen(),
            ),
          ),
        ],
      ),
      // Feature Routes
      GoRoute(
        path: '/kundli/detail',
        builder: (context, state) => const KundliDetailScreen(),
      ),
      GoRoute(
        path: '/ai-chat',
        builder: (context, state) => const AiChatScreen(),
      ),
      GoRoute(
        path: '/predictions',
        builder: (context, state) => const PredictionsScreen(),
      ),
      GoRoute(
        path: '/numerology',
        builder: (context, state) => const NumerologyScreen(),
      ),
      GoRoute(
        path: '/palm-reading',
        builder: (context, state) => const PalmReadingScreen(),
      ),
      GoRoute(
        path: '/face-reading',
        builder: (context, state) => const FaceReadingScreen(),
      ),
      GoRoute(
        path: '/astrologers',
        builder: (context, state) => const AstrologerListScreen(),
      ),
      GoRoute(
        path: '/consultation',
        builder: (context, state) => const ConsultationScreen(),
      ),
      GoRoute(
        path: '/wallet',
        builder: (context, state) => const WalletScreen(),
      ),
      GoRoute(
        path: '/settings',
        builder: (context, state) => const SettingsScreen(),
      ),
      GoRoute(
        path: '/premium',
        builder: (context, state) => const PremiumScreen(),
      ),
    ],
  );
});
