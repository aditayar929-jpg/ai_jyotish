// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'numerology_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NumerologyModel _$NumerologyModelFromJson(Map<String, dynamic> json) =>
    NumerologyModel(
      userId: json['userId'] as String,
      name: json['name'] as String,
      dateOfBirth: DateTime.parse(json['dateOfBirth'] as String),
      lifePathNumber: (json['lifePathNumber'] as num).toInt(),
      destinyNumber: (json['destinyNumber'] as num).toInt(),
      soulNumber: (json['soulNumber'] as num).toInt(),
      personalityNumber: (json['personalityNumber'] as num).toInt(),
      birthdayNumber: (json['birthdayNumber'] as num).toInt(),
      powerNumber: (json['powerNumber'] as num).toInt(),
      lifePathMeaning: json['lifePathMeaning'] as String,
      destinyMeaning: json['destinyMeaning'] as String,
      soulMeaning: json['soulMeaning'] as String,
      personalityMeaning: json['personalityMeaning'] as String,
      luckyNumbers: (json['luckyNumbers'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      luckyColor: json['luckyColor'] as String,
      luckyDay: json['luckyDay'] as String,
      luckyGemstone: json['luckyGemstone'] as String,
      careerGuidance: json['careerGuidance'] as String,
      relationshipGuidance: json['relationshipGuidance'] as String,
      healthGuidance: json['healthGuidance'] as String,
      spiritualGuidance: json['spiritualGuidance'] as String,
      compatibleNumbers: (json['compatibleNumbers'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      challengingNumbers: (json['challengingNumbers'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$NumerologyModelToJson(NumerologyModel instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'name': instance.name,
      'dateOfBirth': instance.dateOfBirth.toIso8601String(),
      'lifePathNumber': instance.lifePathNumber,
      'destinyNumber': instance.destinyNumber,
      'soulNumber': instance.soulNumber,
      'personalityNumber': instance.personalityNumber,
      'birthdayNumber': instance.birthdayNumber,
      'powerNumber': instance.powerNumber,
      'lifePathMeaning': instance.lifePathMeaning,
      'destinyMeaning': instance.destinyMeaning,
      'soulMeaning': instance.soulMeaning,
      'personalityMeaning': instance.personalityMeaning,
      'luckyNumbers': instance.luckyNumbers,
      'luckyColor': instance.luckyColor,
      'luckyDay': instance.luckyDay,
      'luckyGemstone': instance.luckyGemstone,
      'careerGuidance': instance.careerGuidance,
      'relationshipGuidance': instance.relationshipGuidance,
      'healthGuidance': instance.healthGuidance,
      'spiritualGuidance': instance.spiritualGuidance,
      'compatibleNumbers': instance.compatibleNumbers,
      'challengingNumbers': instance.challengingNumbers,
    };
