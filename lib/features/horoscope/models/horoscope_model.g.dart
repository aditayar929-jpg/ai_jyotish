// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'horoscope_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HoroscopeModel _$HoroscopeModelFromJson(Map<String, dynamic> json) =>
    HoroscopeModel(
      zodiacSign: json['zodiacSign'] as String,
      date: json['date'] as String,
      period: json['period'] as String,
      summary: json['summary'] as String,
      love: json['love'] as String,
      career: json['career'] as String,
      health: json['health'] as String,
      finance: json['finance'] as String,
      spiritual: json['spiritual'] as String,
      luckyNumber: (json['luckyNumber'] as num).toInt(),
      luckyColor: json['luckyColor'] as String,
      luckyTime: json['luckyTime'] as String,
      compatibility: json['compatibility'] as String,
      rating: (json['rating'] as num).toInt(),
      keywords:
          (json['keywords'] as List<dynamic>).map((e) => e as String).toList(),
    );

Map<String, dynamic> _$HoroscopeModelToJson(HoroscopeModel instance) =>
    <String, dynamic>{
      'zodiacSign': instance.zodiacSign,
      'date': instance.date,
      'period': instance.period,
      'summary': instance.summary,
      'love': instance.love,
      'career': instance.career,
      'health': instance.health,
      'finance': instance.finance,
      'spiritual': instance.spiritual,
      'luckyNumber': instance.luckyNumber,
      'luckyColor': instance.luckyColor,
      'luckyTime': instance.luckyTime,
      'compatibility': instance.compatibility,
      'rating': instance.rating,
      'keywords': instance.keywords,
    };
