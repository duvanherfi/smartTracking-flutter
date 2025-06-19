import 'package:json_annotation/json_annotation.dart';
import 'package:latlong2/latlong.dart';
import 'package:smart_tracking/api/model/position_server.dart';
import 'package:turf/turf.dart';

part 'trip.g.dart';

@JsonSerializable(includeIfNull: false)
class Trip {
  @JsonKey(name: "_id")
  String? id;
  @JsonKey(name: "DeviceID")
  int? deviceId;
  @JsonKey(name: "StartPositionID")
  int? startPositionId;
  @JsonKey(name: "StartLat")
  double? startLat;
  @JsonKey(name: "StartLon")
  double? startLon;
  @JsonKey(name: "StartTime")
  DateTime? startTime;
  @JsonKey(name: "StartOdometer")
  double? startOdometer;
  @JsonKey(name: "EndPositionID")
  int? endPositionId;
  @JsonKey(name: "EndLat")
  double? endLat;
  @JsonKey(name: "EndLon")
  double? endLon;
  @JsonKey(name: "EndTime")
  DateTime? endTime;
  @JsonKey(name: "EndOdometer")
  double? endOdometer;
  @JsonKey(name: "Distance")
  double? distance;
  @JsonKey(name: "Duration")
  int? duration;
  @JsonKey(name: "AverageSpeed")
  double? averageSpeed;
  @JsonKey(name: "MaxSpeed")
  double? maxSpeed;
  @JsonKey(name: "Positions")
  List<PositionServer>? positions;



  Trip({
    required this.id,
    this.deviceId,
    this.startPositionId,
    this.startLat,
    this.startLon,
    this.startTime,
    this.startOdometer,
    this.endPositionId,
    this.endLat,
    this.endLon,
    this.endTime,
    this.endOdometer,
    this.distance,
    this.duration,
    this.averageSpeed,
    this.maxSpeed,
    this.positions,
  });

  factory Trip.fromJson(Map<String, dynamic> json) => _$TripFromJson(json);

  Map<String, dynamic> toJson() => _$TripToJson(this);

  LatLng startPoint() {
    return LatLng(startLat ?? 0, startLon ?? 0);
  }

  LatLng endPoint() {
    return LatLng(endLat ?? 0, endLon ?? 0);
  }

  List<dynamic> coordinates() {
    List<dynamic> list = positions!.map(
            (p) => [p.lon, p.lat]
    ).toList();
    return [list];
  }

  LatLng centerPoint() {
    return startLat != null && startLon != null && endLat != null && endLon != null
        ? LatLng.fromJson(
            center(GeoJSONObject.fromJson({
            "type": "Polygon",
            "coordinates": coordinates()
            })).toJson()['geometry']
          )
        : LatLng(0, 0);

  }
}
