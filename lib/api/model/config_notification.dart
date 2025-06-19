import 'package:json_annotation/json_annotation.dart';

part 'config_notification.g.dart';

@JsonSerializable(includeIfNull: false)
class ConfigNotification {
  @JsonKey(name: "_id")
  String? id;
  @JsonKey(name: "name")
  String? name;
  @JsonKey(name: "is_enabled")
  bool? isEnabled;
  @JsonKey(name: "user_id")
  String? userId;


  ConfigNotification({
    required this.id,
    this.name,
    this.isEnabled,
    this.userId
  });

  factory ConfigNotification.fromJson(Map<String, dynamic> json) => _$ConfigNotificationFromJson(json);

  Map<String, dynamic> toJson() => _$ConfigNotificationToJson(this);

  @override
  String toString() {
    return "$name";
  }
}
