import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dio/dio.dart';

import '../../../core/di/service_locator.dart';
import '../../../core/constants/api_constants.dart';
import '../models/horoscope_model.dart';

final selectedZodiacProvider = StateProvider<String>((ref) => 'Aries');

final dailyHoroscopeProvider = FutureProvider.family<HoroscopeModel, String>((ref, zodiacSign) async {
  final dio = getIt<Dio>();
  try {
    final response = await dio.get('${ApiConstants.dailyHoroscope}/$zodiacSign');
    return HoroscopeModel.fromJson(response.data['data']['horoscope']);
  } catch (e) {
    // Return mock data on error
    return HoroscopeModel(
      zodiacSign: zodiacSign,
      date: DateTime.now().toString().split(' ')[0],
      period: 'daily',
      summary: 'The stars are aligning in your favor today.',
      love: 'Romance is in the air.',
      career: 'New opportunities await.',
      health: 'Focus on well-being.',
      finance: 'Financial stability improves.',
      spiritual: 'Connect with your inner self.',
      luckyNumber: 7,
      luckyColor: 'Gold',
      luckyTime: '10:00 AM',
      compatibility: 'Leo',
      rating: 4,
      keywords: ['growth', 'opportunity', 'love'],
    );
  }
});

final weeklyHoroscopeProvider = FutureProvider.family<HoroscopeModel, String>((ref, zodiacSign) async {
  final dio = getIt<Dio>();
  try {
    final response = await dio.get('${ApiConstants.weeklyHoroscope}/$zodiacSign');
    return HoroscopeModel.fromJson(response.data['data']['horoscope']);
  } catch (e) {
    return HoroscopeModel(
      zodiacSign: zodiacSign,
      date: DateTime.now().toString().split(' ')[0],
      period: 'weekly',
      summary: 'This week brings positive energy.',
      love: 'Deep connections strengthen.',
      career: 'Professional growth ahead.',
      health: 'Maintain balance.',
      finance: 'Smart investments pay off.',
      spiritual: 'Meditation brings clarity.',
      luckyNumber: 3,
      luckyColor: 'Blue',
      luckyTime: 'Morning',
      compatibility: 'Sagittarius',
      rating: 4,
      keywords: ['balance', 'growth', 'wisdom'],
    );
  }
});
