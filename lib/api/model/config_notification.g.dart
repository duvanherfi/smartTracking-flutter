// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'config_notification.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ConfigNotification _$ConfigNotificationFromJson(Map<String, dynamic> json) =>
    ConfigNotification(
      id: json['_id'] as String?,
      name: json['name'] as String?,
      isEnabled: json['is_enabled'] as bool?,
      userId: json['user_id'] as String?,
    );

Map<String, dynamic> _$ConfigNotificationToJson(ConfigNotification instance) =>
    <String, dynamic>{
      if (instance.id case final value?) '_id': value,
      if (instance.name case final value?) 'name': value,
      if (instance.isEnabled case final value?) 'is_enabled': value,
      if (instance.userId case final value?) 'user_id': value,
    };
