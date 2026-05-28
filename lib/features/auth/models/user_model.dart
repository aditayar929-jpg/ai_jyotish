import 'package:json_annotation/json_annotation.dart';

part 'user_model.g.dart';

@JsonSerializable()
class UserModel {
  final String id;
  final String? name;
  final String? email;
  final String? phone;
  final String? photoUrl;
  final String? gender;
  final DateTime? dateOfBirth;
  final String? timeOfBirth;
  final String? placeOfBirth;
  final double? latitude;
  final double? longitude;
  final String? zodiacSign;
  final String? relationshipStatus;
  final String? language;
  final bool isPremium;
  final int walletCoins;
  final DateTime createdAt;
  final DateTime? updatedAt;

  const UserModel({
    required this.id,
    this.name,
    this.email,
    this.phone,
    this.photoUrl,
    this.gender,
    this.dateOfBirth,
    this.timeOfBirth,
    this.placeOfBirth,
    this.latitude,
    this.longitude,
    this.zodiacSign,
    this.relationshipStatus,
    this.language,
    this.isPremium = false,
    this.walletCoins = 0,
    required this.createdAt,
    this.updatedAt,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => _$UserModelFromJson(json);
  Map<String, dynamic> toJson() => _$UserModelToJson(this);

  UserModel copyWith({
    String? id,
    String? name,
    String? email,
    String? phone,
    String? photoUrl,
    String? gender,
    DateTime? dateOfBirth,
    String? timeOfBirth,
    String? placeOfBirth,
    double? latitude,
    double? longitude,
    String? zodiacSign,
    String? relationshipStatus,
    String? language,
    bool? isPremium,
    int? walletCoins,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return UserModel(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      photoUrl: photoUrl ?? this.photoUrl,
      gender: gender ?? this.gender,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
      timeOfBirth: timeOfBirth ?? this.timeOfBirth,
      placeOfBirth: placeOfBirth ?? this.placeOfBirth,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      zodiacSign: zodiacSign ?? this.zodiacSign,
      relationshipStatus: relationshipStatus ?? this.relationshipStatus,
      language: language ?? this.language,
      isPremium: isPremium ?? this.isPremium,
      walletCoins: walletCoins ?? this.walletCoins,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
