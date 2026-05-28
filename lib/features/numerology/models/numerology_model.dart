import 'package:json_annotation/json_annotation.dart';

part 'numerology_model.g.dart';

@JsonSerializable()
class NumerologyModel {
  final String userId;
  final String name;
  final DateTime dateOfBirth;
  final int lifePathNumber;
  final int destinyNumber;
  final int soulNumber;
  final int personalityNumber;
  final int birthdayNumber;
  final int powerNumber;
  final String lifePathMeaning;
  final String destinyMeaning;
  final String soulMeaning;
  final String personalityMeaning;
  final List<String> luckyNumbers;
  final String luckyColor;
  final String luckyDay;
  final String luckyGemstone;
  final String careerGuidance;
  final String relationshipGuidance;
  final String healthGuidance;
  final String spiritualGuidance;
  final List<String> compatibleNumbers;
  final List<String> challengingNumbers;

  const NumerologyModel({
    required this.userId,
    required this.name,
    required this.dateOfBirth,
    required this.lifePathNumber,
    required this.destinyNumber,
    required this.soulNumber,
    required this.personalityNumber,
    required this.birthdayNumber,
    required this.powerNumber,
    required this.lifePathMeaning,
    required this.destinyMeaning,
    required this.soulMeaning,
    required this.personalityMeaning,
    required this.luckyNumbers,
    required this.luckyColor,
    required this.luckyDay,
    required this.luckyGemstone,
    required this.careerGuidance,
    required this.relationshipGuidance,
    required this.healthGuidance,
    required this.spiritualGuidance,
    required this.compatibleNumbers,
    required this.challengingNumbers,
  });

  factory NumerologyModel.fromJson(Map<String, dynamic> json) => _$NumerologyModelFromJson(json);
  Map<String, dynamic> toJson() => _$NumerologyModelToJson(this);
}
