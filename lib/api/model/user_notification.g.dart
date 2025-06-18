// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_notification.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserNotification _$UserNotificationFromJson(Map<String, dynamic> json) =>
    UserNotification(
      id: json['_id'] as String?,
      translate: json['translate'] as String?,
      serverTime: json['server_time'] == null
          ? null
          : DateTime.parse(json['server_time'] as String),
      lat: (json['lat'] as num?)?.toDouble(),
      lon: (json['lon'] as num?)?.toDouble(),
      isEnabled: json['is_enabled'] as bool?,
      userId: json['user_id'] as String?,
      plates: json['plates'] as String?,
      labelDirection: json['label_direction'] as String?,
      geoFence: json['geo_fence'] as String?,
      type: json['type'] as String?,
    );

Map<String, dynamic> _$UserNotificationToJson(UserNotification instance) =>
    <String, dynamic>{
      if (instance.id case final value?) '_id': value,
      if (instance.translate case final value?) 'translate': value,
      if (instance.serverTime?.toIso8601String() case final value?)
        'server_time': value,
      if (instance.lat case final value?) 'lat': value,
      if (instance.lon case final value?) 'lon': value,
      if (instance.isEnabled case final value?) 'is_enabled': value,
      if (instance.userId case final value?) 'user_id': value,
      if (instance.plates case final value?) 'plates': value,
      if (instance.labelDirection case final value?) 'label_direction': value,
      if (instance.geoFence case final value?) 'geo_fence': value,
      if (instance.type case final value?) 'type': value,
    };
