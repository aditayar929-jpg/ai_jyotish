import 'package:json_annotation/json_annotation.dart';

part 'horoscope_model.g.dart';

@JsonSerializable()
class HoroscopeModel {
  final String zodiacSign;
  final String date;
  final String period; // daily, weekly, monthly, yearly
  final String summary;
  final String love;
  final String career;
  final String health;
  final String finance;
  final String spiritual;
  final int luckyNumber;
  final String luckyColor;
  final String luckyTime;
  final String compatibility;
  final int rating; // 1-5
  final List<String> keywords;

  const HoroscopeModel({
    required this.zodiacSign,
    required this.date,
    required this.period,
    required this.summary,
    required this.love,
    required this.career,
    required this.health,
    required this.finance,
    required this.spiritual,
    required this.luckyNumber,
    required this.luckyColor,
    required this.luckyTime,
    required this.compatibility,
    required this.rating,
    required this.keywords,
  });

  factory HoroscopeModel.fromJson(Map<String, dynamic> json) => _$HoroscopeModelFromJson(json);
  Map<String, dynamic> toJson() => _$HoroscopeModelToJson(this);
}
