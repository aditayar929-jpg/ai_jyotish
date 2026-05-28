// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'kundli_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

KundliModel _$KundliModelFromJson(Map<String, dynamic> json) => KundliModel(
      id: json['id'] as String,
      userId: json['userId'] as String,
      name: json['name'] as String,
      dateOfBirth: DateTime.parse(json['dateOfBirth'] as String),
      timeOfBirth: json['timeOfBirth'] as String,
      placeOfBirth: json['placeOfBirth'] as String,
      latitude: (json['latitude'] as num).toDouble(),
      longitude: (json['longitude'] as num).toDouble(),
      rashi: json['rashi'] as String,
      nakshatra: json['nakshatra'] as String,
      lagna: json['lagna'] as String,
      planets: (json['planets'] as List<dynamic>)
          .map((e) => PlanetPosition.fromJson(e as Map<String, dynamic>))
          .toList(),
      houses: (json['houses'] as List<dynamic>)
          .map((e) => HouseData.fromJson(e as Map<String, dynamic>))
          .toList(),
      doshas: (json['doshas'] as List<dynamic>)
          .map((e) => DoshaModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      kundliType: json['kundliType'] as String? ?? 'north_indian',
      createdAt: DateTime.parse(json['createdAt'] as String),
    );

Map<String, dynamic> _$KundliModelToJson(KundliModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'name': instance.name,
      'dateOfBirth': instance.dateOfBirth.toIso8601String(),
      'timeOfBirth': instance.timeOfBirth,
      'placeOfBirth': instance.placeOfBirth,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'rashi': instance.rashi,
      'nakshatra': instance.nakshatra,
      'lagna': instance.lagna,
      'planets': instance.planets,
      'houses': instance.houses,
      'doshas': instance.doshas,
      'kundliType': instance.kundliType,
      'createdAt': instance.createdAt.toIso8601String(),
    };

PlanetPosition _$PlanetPositionFromJson(Map<String, dynamic> json) =>
    PlanetPosition(
      planet: json['planet'] as String,
      rashi: json['rashi'] as String,
      degree: (json['degree'] as num).toDouble(),
      house: (json['house'] as num).toInt(),
      nakshatra: json['nakshatra'] as String,
      isRetrograde: json['isRetrograde'] as bool? ?? false,
    );

Map<String, dynamic> _$PlanetPositionToJson(PlanetPosition instance) =>
    <String, dynamic>{
      'planet': instance.planet,
      'rashi': instance.rashi,
      'degree': instance.degree,
      'house': instance.house,
      'nakshatra': instance.nakshatra,
      'isRetrograde': instance.isRetrograde,
    };

HouseData _$HouseDataFromJson(Map<String, dynamic> json) => HouseData(
      houseNumber: (json['houseNumber'] as num).toInt(),
      sign: json['sign'] as String,
      planets:
          (json['planets'] as List<dynamic>).map((e) => e as String).toList(),
      significance: json['significance'] as String,
    );

Map<String, dynamic> _$HouseDataToJson(HouseData instance) => <String, dynamic>{
      'houseNumber': instance.houseNumber,
      'sign': instance.sign,
      'planets': instance.planets,
      'significance': instance.significance,
    };

DoshaModel _$DoshaModelFromJson(Map<String, dynamic> json) => DoshaModel(
      name: json['name'] as String,
      description: json['description'] as String,
      severity: json['severity'] as String,
      remedies: (json['remedies'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      isPresent: json['isPresent'] as bool,
    );

Map<String, dynamic> _$DoshaModelToJson(DoshaModel instance) =>
    <String, dynamic>{
      'name': instance.name,
      'description': instance.description,
      'severity': instance.severity,
      'remedies': instance.remedies,
      'isPresent': instance.isPresent,
    };
