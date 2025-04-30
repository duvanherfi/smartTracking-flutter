import 'package:json_annotation/json_annotation.dart';

part 'centroid_geojson.g.dart';

@JsonSerializable(includeIfNull: false)
class CentroidGeojson {
  @JsonKey(name: "type")
  String type;
  @JsonKey(
    name: "coordinates",
    fromJson: _stringListToDoubleList,
  )
  List<double> coordinates;

  CentroidGeojson({
    required this.type,
    required this.coordinates,
  });

  factory CentroidGeojson.fromJson(Map<String, dynamic> json) => _$CentroidGeojsonFromJson(json);

  Map<String, dynamic> toJson() => _$CentroidGeojsonToJson(this);

  static List<double> _stringListToDoubleList(List<dynamic> list) =>
      list.map((e) => double.parse(e.toString())).toList();
}
