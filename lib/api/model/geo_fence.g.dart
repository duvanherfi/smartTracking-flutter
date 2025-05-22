// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'geo_fence.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GeoFence _$GeoFenceFromJson(Map<String, dynamic> json) => GeoFence(
      id: json['_id'] as String,
      areaGeojson: json['area_geojson'] == null
          ? null
          : AreaGeoJson.fromJson(json['area_geojson'] as Map<String, dynamic>),
      centroidGeojson: json['centroid_geojson'] == null
          ? null
          : CentroidGeojson.fromJson(
              json['centroid_geojson'] as Map<String, dynamic>),
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
      description: json['description'] as String?,
      isEnabled: json['is_enabled'] as bool?,
      name: json['name'] as String?,
      updatedAt: json['updated_at'] == null
          ? null
          : DateTime.parse(json['updated_at'] as String),
      userId: json['user_id'] as String?,
      vehicleIds: (json['vehicle_ids'] as List<dynamic>?)
          ?.map((e) => e as String?)
          .toList(),
      labelDirection: json['label_direction'] as String?,
      lat: (json['lat'] as num?)?.toDouble(),
      lon: (json['lon'] as num?)?.toDouble(),
      radius: (json['radius'] as num?)?.toDouble(),
      typeCD: (json['type_cd'] as num?)?.toInt(),
    );

Map<String, dynamic> _$GeoFenceToJson(GeoFence instance) => <String, dynamic>{
      '_id': instance.id,
      if (instance.areaGeojson case final value?) 'area_geojson': value,
      if (instance.centroidGeojson case final value?) 'centroid_geojson': value,
      if (instance.createdAt?.toIso8601String() case final value?)
        'created_at': value,
      if (instance.description case final value?) 'description': value,
      if (instance.isEnabled case final value?) 'is_enabled': value,
      if (instance.name case final value?) 'name': value,
      if (instance.updatedAt?.toIso8601String() case final value?)
        'updated_at': value,
      if (instance.labelDirection case final value?) 'label_direction': value,
      if (instance.lat case final value?) 'lat': value,
      if (instance.lon case final value?) 'lon': value,
      if (instance.radius case final value?) 'radius': value,
      if (instance.userId case final value?) 'user_id': value,
      if (instance.vehicleIds case final value?) 'vehicle_ids': value,
      if (instance.typeCD case final value?) 'type_cd': value,
    };
