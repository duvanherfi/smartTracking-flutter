// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vehicle.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Vehicle _$VehicleFromJson(Map<String, dynamic> json) => Vehicle(
      id: json['_id'] as String?,
      batteryLevel: json['battery_level'] as String?,
      blocked: json['blocked'] as bool?,
      category: json['category'] as String?,
      charge: json['charge'] as bool?,
      course: json['course'] as String?,
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
      distance: json['distance'] as String?,
      externalId: json['external_id'] as String?,
      ignition: json['ignition'] as bool?,
      ip: json['ip'] as String?,
      isEnabled: json['is_enabled'] as bool?,
      lastUpdateFromGps: json['last_update_from_gps'] == null
          ? null
          : DateTime.parse(json['last_update_from_gps'] as String),
      lastUpdateFromServer: json['last_update_from_server'] == null
          ? null
          : DateTime.parse(json['last_update_from_server'] as String),
      lat: json['lat'] as String?,
      lon: json['lon'] as String?,
      model: json['model'] as String?,
      motion: json['motion'] as bool?,
      plates: json['plates'] as String?,
      rssi: json['rssi'] as String?,
      speedLimit: (json['speed_limit'] as num?)?.toInt(),
      totalDistance: json['total_distance'] as String?,
      updatedAt: json['updated_at'] == null
          ? null
          : DateTime.parse(json['updated_at'] as String),
      userId: json['user_id'] as String?,
      averageSpeed: json['average_speed'] as String?,
      maxSpeed: json['max_speed'] as String?,
      labelDirection: json['label_direction'] as String?,
    );

Map<String, dynamic> _$VehicleToJson(Vehicle instance) => <String, dynamic>{
      if (instance.id case final value?) '_id': value,
      if (instance.batteryLevel case final value?) 'battery_level': value,
      if (instance.blocked case final value?) 'blocked': value,
      if (instance.category case final value?) 'category': value,
      if (instance.charge case final value?) 'charge': value,
      if (instance.course case final value?) 'course': value,
      if (instance.createdAt?.toIso8601String() case final value?)
        'created_at': value,
      if (instance.distance case final value?) 'distance': value,
      if (instance.externalId case final value?) 'external_id': value,
      if (instance.ignition case final value?) 'ignition': value,
      if (instance.ip case final value?) 'ip': value,
      if (instance.isEnabled case final value?) 'is_enabled': value,
      if (instance.lastUpdateFromGps?.toIso8601String() case final value?)
        'last_update_from_gps': value,
      if (instance.lastUpdateFromServer?.toIso8601String() case final value?)
        'last_update_from_server': value,
      if (instance.lat case final value?) 'lat': value,
      if (instance.lon case final value?) 'lon': value,
      if (instance.model case final value?) 'model': value,
      if (instance.motion case final value?) 'motion': value,
      if (instance.plates case final value?) 'plates': value,
      if (instance.rssi case final value?) 'rssi': value,
      if (instance.speedLimit case final value?) 'speed_limit': value,
      if (instance.totalDistance case final value?) 'total_distance': value,
      if (instance.updatedAt?.toIso8601String() case final value?)
        'updated_at': value,
      if (instance.userId case final value?) 'user_id': value,
      if (instance.averageSpeed case final value?) 'average_speed': value,
      if (instance.maxSpeed case final value?) 'max_speed': value,
      if (instance.labelDirection case final value?) 'label_direction': value,
    };
