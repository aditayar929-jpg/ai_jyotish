// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserModel _$UserModelFromJson(Map<String, dynamic> json) => UserModel(
      id: json['id'] as String,
      name: json['name'] as String?,
      email: json['email'] as String?,
      phone: json['phone'] as String?,
      photoUrl: json['photoUrl'] as String?,
      gender: json['gender'] as String?,
      dateOfBirth: json['dateOfBirth'] == null
          ? null
          : DateTime.parse(json['dateOfBirth'] as String),
      timeOfBirth: json['timeOfBirth'] as String?,
      placeOfBirth: json['placeOfBirth'] as String?,
      latitude: (json['latitude'] as num?)?.toDouble(),
      longitude: (json['longitude'] as num?)?.toDouble(),
      zodiacSign: json['zodiacSign'] as String?,
      relationshipStatus: json['relationshipStatus'] as String?,
      language: json['language'] as String?,
      isPremium: json['isPremium'] as bool? ?? false,
      walletCoins: (json['walletCoins'] as num?)?.toInt() ?? 0,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$UserModelToJson(UserModel instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'email': instance.email,
      'phone': instance.phone,
      'photoUrl': instance.photoUrl,
      'gender': instance.gender,
      'dateOfBirth': instance.dateOfBirth?.toIso8601String(),
      'timeOfBirth': instance.timeOfBirth,
      'placeOfBirth': instance.placeOfBirth,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'zodiacSign': instance.zodiacSign,
      'relationshipStatus': instance.relationshipStatus,
      'language': instance.language,
      'isPremium': instance.isPremium,
      'walletCoins': instance.walletCoins,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
    };
