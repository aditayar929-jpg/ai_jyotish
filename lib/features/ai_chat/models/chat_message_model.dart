import 'package:json_annotation/json_annotation.dart';

part 'chat_message_model.g.dart';

@JsonSerializable()
class ChatMessageModel {
  final String id;
  final String userId;
  final String message;
  final String response;
  final bool isUser;
  final DateTime timestamp;
  final String? category; // career, marriage, health, finance, general
  final String? mood;
  final List<String>? suggestions;

  const ChatMessageModel({
    required this.id,
    required this.userId,
    required this.message,
    this.response = '',
    required this.isUser,
    required this.timestamp,
    this.category,
    this.mood,
    this.suggestions,
  });

  factory ChatMessageModel.fromJson(Map<String, dynamic> json) => _$ChatMessageModelFromJson(json);
  Map<String, dynamic> toJson() => _$ChatMessageModelToJson(this);
}

@JsonSerializable()
class ChatSessionModel {
  final String id;
  final String userId;
  final String title;
  final List<ChatMessageModel> messages;
  final DateTime createdAt;
  final DateTime? updatedAt;

  const ChatSessionModel({
    required this.id,
    required this.userId,
    required this.title,
    required this.messages,
    required this.createdAt,
    this.updatedAt,
  });

  factory ChatSessionModel.fromJson(Map<String, dynamic> json) => _$ChatSessionModelFromJson(json);
  Map<String, dynamic> toJson() => _$ChatSessionModelToJson(this);
}
