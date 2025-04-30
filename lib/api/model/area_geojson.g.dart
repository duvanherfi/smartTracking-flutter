// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'area_geojson.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AreaGeoJson _$AreaGeoJsonFromJson(Map<String, dynamic> json) => AreaGeoJson(
      type: json['type'] as String,
      coordinates: (json['coordinates'] as List<dynamic>)
          .map((e) => (e as List<dynamic>)
              .map((e) => (e as List<dynamic>)
                  .map((e) => (e as num).toDouble())
                  .toList())
              .toList())
          .toList(),
    );

Map<String, dynamic> _$AreaGeoJsonToJson(AreaGeoJson instance) =>
    <String, dynamic>{
      'type': instance.type,
      'coordinates': instance.coordinates,
    };
