import 'package:json_annotation/json_annotation.dart';

part 'vehicle.g.dart';

@JsonSerializable(includeIfNull: false)
class Vehicle {
  @JsonKey(name: "_id")
  String? id;
  @JsonKey(name: "battery_level")
  String? batteryLevel;
  @JsonKey(name: "blocked")
  bool? blocked;
  @JsonKey(name: "category")
  String? category;
  @JsonKey(name: "charge")
  bool? charge;
  @JsonKey(name: "course")
  String? course;
  @JsonKey(name: "created_at")
  DateTime? createdAt;
  @JsonKey(name: "distance")
  String? distance;
  @JsonKey(name: "external_id")
  String? externalId;
  @JsonKey(name: "ignition")
  bool? ignition;
  @JsonKey(name: "ip")
  String? ip;
  @JsonKey(name: "is_enabled")
  bool? isEnabled;
  @JsonKey(name: "last_update_from_gps")
  DateTime? lastUpdateFromGps;
  @JsonKey(name: "last_update_from_server")
  DateTime? lastUpdateFromServer;
  @JsonKey(name: "lat")
  String? lat;
  @JsonKey(name: "lon")
  String? lon;
  @JsonKey(name: "model")
  String? model;
  @JsonKey(name: "motion")
  bool? motion;
  @JsonKey(name: "plates")
  String? plates;
  @JsonKey(name: "rssi")
  String? rssi;
  @JsonKey(name: "speed_limit")
  int? speedLimit;
  @JsonKey(name: "total_distance")
  String? totalDistance;
  @JsonKey(name: "updated_at")
  DateTime? updatedAt;
  @JsonKey(name: "user_id")
  String? userId;
  @JsonKey(name: "average_speed")
  String? averageSpeed;
  @JsonKey(name: "max_speed")
  String? maxSpeed;
  @JsonKey(name: "label_direction")
  String? labelDirection;

  Vehicle({
    required this.id,
    this.batteryLevel,
    this.blocked,
    this.category,
    this.charge,
    this.course,
    this.createdAt,
    this.distance,
    this.externalId,
    this.ignition,
    this.ip,
    this.isEnabled,
    this.lastUpdateFromGps,
    this.lastUpdateFromServer,
    this.lat,
    this.lon,
    this.model,
    this.motion,
    this.plates,
    this.rssi,
    this.speedLimit,
    this.totalDistance,
    this.updatedAt,
    this.userId,
    this.averageSpeed,
    this.maxSpeed,
    this.labelDirection,
  });

  factory Vehicle.fromJson(Map<String, dynamic> json) => _$VehicleFromJson(json);

  Map<String, dynamic> toJson() => _$VehicleToJson(this);

  @override
  String toString() {
    return "$plates";
  }
}
