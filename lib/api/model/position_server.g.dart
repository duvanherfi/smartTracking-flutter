// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'position_server.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PositionServer _$PositionServerFromJson(Map<String, dynamic> json) =>
    PositionServer(
      id: json['_id'] as String?,
    )
      ..deviceId = (json['DeviceID'] as num?)?.toInt()
      ..serverTime = json['Servertime'] == null
          ? null
          : DateTime.parse(json['Servertime'] as String)
      ..lat = (json['Latitude'] as num?)?.toDouble()
      ..lon = (json['Longitude'] as num?)?.toDouble()
      ..deviceTime = json['Devicetime'] == null
          ? null
          : DateTime.parse(json['Devicetime'] as String);

Map<String, dynamic> _$PositionServerToJson(PositionServer instance) =>
    <String, dynamic>{
      if (instance.id case final value?) '_id': value,
      if (instance.deviceId case final value?) 'DeviceID': value,
      if (instance.serverTime?.toIso8601String() case final value?)
        'Servertime': value,
      if (instance.lat case final value?) 'Latitude': value,
      if (instance.lon case final value?) 'Longitude': value,
      if (instance.deviceTime?.toIso8601String() case final value?)
        'Devicetime': value,
    };
