import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable(explicitToJson: true, includeIfNull: false)
class User {
  @JsonKey(name: "_id")
  String id;
  @JsonKey(name: "created_at")
  DateTime createdAt;
  @JsonKey(name: "email")
  String email;
  @JsonKey(name: "is_active")
  bool isActive;
  @JsonKey(name: "name")
  String name;
  @JsonKey(name: "phone")
  String phone;
  @JsonKey(name: "updated_at")
  DateTime updatedAt;
  @JsonKey(name: "token")
  String token;
  @JsonKey(name: "session_id")
  String sessionID;
  @JsonKey(name: "push_token")
  String? pushToken;
  @JsonKey(name: "password")
  String? password;
  @JsonKey(name: "password_confirmation")
  String? passwordConfirmation;

  User({
    required this.id,
    required this.createdAt,
    required this.email,
    required this.isActive,
    required this.name,
    required this.phone,
    required this.updatedAt,
    required this.token,
    required this.sessionID,
    this.pushToken,
    this.password,
    this.passwordConfirmation,
  });

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);
}
