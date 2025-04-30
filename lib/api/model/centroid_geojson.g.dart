// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'centroid_geojson.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CentroidGeojson _$CentroidGeojsonFromJson(Map<String, dynamic> json) =>
    CentroidGeojson(
      type: json['type'] as String,
      coordinates:
          CentroidGeojson._stringListToDoubleList(json['coordinates'] as List),
    );

Map<String, dynamic> _$CentroidGeojsonToJson(CentroidGeojson instance) =>
    <String, dynamic>{
      'type': instance.type,
      'coordinates': instance.coordinates,
    };
