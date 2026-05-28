import 'package:json_annotation/json_annotation.dart';

part 'kundli_model.g.dart';

@JsonSerializable()
class KundliModel {
  final String id;
  final String userId;
  final String name;
  final DateTime dateOfBirth;
  final String timeOfBirth;
  final String placeOfBirth;
  final double latitude;
  final double longitude;
  final String rashi;
  final String nakshatra;
  final String lagna;
  final List<PlanetPosition> planets;
  final List<HouseData> houses;
  final List<DoshaModel> doshas;
  final String kundliType; // north_indian, south_indian
  final DateTime createdAt;

  const KundliModel({
    required this.id,
    required this.userId,
    required this.name,
    required this.dateOfBirth,
    required this.timeOfBirth,
    required this.placeOfBirth,
    required this.latitude,
    required this.longitude,
    required this.rashi,
    required this.nakshatra,
    required this.lagna,
    required this.planets,
    required this.houses,
    required this.doshas,
    this.kundliType = 'north_indian',
    required this.createdAt,
  });

  factory KundliModel.fromJson(Map<String, dynamic> json) => _$KundliModelFromJson(json);
  Map<String, dynamic> toJson() => _$KundliModelToJson(this);
}

@JsonSerializable()
class PlanetPosition {
  final String planet;
  final String rashi;
  final double degree;
  final int house;
  final String nakshatra;
  final bool isRetrograde;

  const PlanetPosition({
    required this.planet,
    required this.rashi,
    required this.degree,
    required this.house,
    required this.nakshatra,
    this.isRetrograde = false,
  });

  factory PlanetPosition.fromJson(Map<String, dynamic> json) => _$PlanetPositionFromJson(json);
  Map<String, dynamic> toJson() => _$PlanetPositionToJson(this);
}

@JsonSerializable()
class HouseData {
  final int houseNumber;
  final String sign;
  final List<String> planets;
  final String significance;

  const HouseData({
    required this.houseNumber,
    required this.sign,
    required this.planets,
    required this.significance,
  });

  factory HouseData.fromJson(Map<String, dynamic> json) => _$HouseDataFromJson(json);
  Map<String, dynamic> toJson() => _$HouseDataToJson(this);
}

@JsonSerializable()
class DoshaModel {
  final String name;
  final String description;
  final String severity; // mild, moderate, severe
  final List<String> remedies;
  final bool isPresent;

  const DoshaModel({
    required this.name,
    required this.description,
    required this.severity,
    required this.remedies,
    required this.isPresent,
  });

  factory DoshaModel.fromJson(Map<String, dynamic> json) => _$DoshaModelFromJson(json);
  Map<String, dynamic> toJson() => _$DoshaModelToJson(this);
}
