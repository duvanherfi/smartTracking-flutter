import 'package:json_annotation/json_annotation.dart';

import 'area_geojson.dart';
import 'centroid_geojson.dart';

part 'geo_fence.g.dart';

@JsonSerializable(includeIfNull: false)
class GeoFence {
  @JsonKey(name: "_id")
  String id;
  @JsonKey(name: "area_geojson")
  AreaGeoJson? areaGeojson;
  @JsonKey(name: "centroid_geojson")
  CentroidGeojson? centroidGeojson;
  @JsonKey(name: "created_at")
  DateTime? createdAt;
  @JsonKey(name: "description")
  String? description;
  @JsonKey(name: "is_enabled")
  bool? isEnabled;
  @JsonKey(name: "name")
  String? name;
  @JsonKey(name: "updated_at")
  DateTime? updatedAt;
  @JsonKey(name: "label_direction")
  String? labelDirection;
  @JsonKey(name: "lat")
  double? lat;
  @JsonKey(name: "lon")
  double? lon;
  @JsonKey(name: "radius")
  double? radius;
  @JsonKey(name: "user_id")
  String? userId;
  @JsonKey(name: "vehicle_ids")
  List<String?>? vehicleIds;
  @JsonKey(name: "type_cd")
  int? typeCD;

  GeoFence({
    required this.id,
    this.areaGeojson,
    this.centroidGeojson,
    this.createdAt,
    this.description,
    this.isEnabled,
    this.name,
    this.updatedAt,
    this.userId,
    this.vehicleIds,
    this.labelDirection,
    this.lat,
    this.lon,
    this.radius,
    this.typeCD
  });

  factory GeoFence.fromJson(Map<String, dynamic> json) => _$GeoFenceFromJson(json);

  Map<String, dynamic> toJson() => _$GeoFenceToJson(this);
}
