import 'package:json_annotation/json_annotation.dart';

part 'user_notification.g.dart';

@JsonSerializable(includeIfNull: false)
class UserNotification {
  @JsonKey(name: "_id")
  String? id;
  @JsonKey(name: "translate")
  String? translate;
  @JsonKey(name: "server_time")
  DateTime? serverTime;
  @JsonKey(name: "lat")
  double? lat;
  @JsonKey(name: "lon")
  double? lon;
  @JsonKey(name: "is_enabled")
  bool? isEnabled;
  @JsonKey(name: "user_id")
  String? userId;
  @JsonKey(name: "plates")
  String? plates;
  @JsonKey(name: "label_direction")
  String? labelDirection;
  @JsonKey(name: "geo_fence")
  String? geoFence;
  @JsonKey(name: "type")
  String? type;


  UserNotification({
    required this.id,
    this.translate,
    this.serverTime,
    this.lat,
    this.lon,
    this.isEnabled,
    this.userId,
    this.plates,
    this.labelDirection,
    this.geoFence,
    this.type,
  });

  factory UserNotification.fromJson(Map<String, dynamic> json) => _$UserNotificationFromJson(json);

  Map<String, dynamic> toJson() => _$UserNotificationToJson(this);

  @override
  String toString() {
    return "$translate";
  }
}
