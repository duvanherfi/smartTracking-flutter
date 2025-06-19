import 'package:json_annotation/json_annotation.dart';
import 'package:latlong2/latlong.dart';

part 'position_server.g.dart';

@JsonSerializable(includeIfNull: false)
class PositionServer {
  @JsonKey(name: "_id")
  String? id;
  @JsonKey(name: "DeviceID")
  int? deviceId;
  @JsonKey(name: "Servertime")
  DateTime? serverTime;
  @JsonKey(name: "Latitude")
  double? lat;
  @JsonKey(name: "Longitude")
  double? lon;
  @JsonKey(name: "Devicetime")
  DateTime? deviceTime;



  PositionServer({
    required this.id,
  });

  factory PositionServer.fromJson(Map<String, dynamic> json) => _$PositionServerFromJson(json);

  Map<String, dynamic> toJson() => _$PositionServerToJson(this);

  LatLng point() {
    return LatLng(lat ?? 0, lon ?? 0);
  }
}
