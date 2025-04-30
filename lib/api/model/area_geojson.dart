import 'package:json_annotation/json_annotation.dart';

part 'area_geojson.g.dart';

@JsonSerializable(includeIfNull: false)
class AreaGeoJson {
  @JsonKey(name: "type")
  String type;
  @JsonKey(name: "coordinates")
  List<List<List<double>>> coordinates;

  AreaGeoJson({
    required this.type,
    required this.coordinates,
  });

  factory AreaGeoJson.fromJson(Map<String, dynamic> json) => _$AreaGeoJsonFromJson(json);

  Map<String, dynamic> toJson() => _$AreaGeoJsonToJson(this);
}
