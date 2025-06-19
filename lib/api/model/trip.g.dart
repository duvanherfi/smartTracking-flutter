// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'trip.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Trip _$TripFromJson(Map<String, dynamic> json) => Trip(
      id: json['_id'] as String?,
      deviceId: (json['DeviceID'] as num?)?.toInt(),
      startPositionId: (json['StartPositionID'] as num?)?.toInt(),
      startLat: (json['StartLat'] as num?)?.toDouble(),
      startLon: (json['StartLon'] as num?)?.toDouble(),
      startTime: json['StartTime'] == null
          ? null
          : DateTime.parse(json['StartTime'] as String),
      startOdometer: (json['StartOdometer'] as num?)?.toDouble(),
      endPositionId: (json['EndPositionID'] as num?)?.toInt(),
      endLat: (json['EndLat'] as num?)?.toDouble(),
      endLon: (json['EndLon'] as num?)?.toDouble(),
      endTime: json['EndTime'] == null
          ? null
          : DateTime.parse(json['EndTime'] as String),
      endOdometer: (json['EndOdometer'] as num?)?.toDouble(),
      distance: (json['Distance'] as num?)?.toDouble(),
      duration: (json['Duration'] as num?)?.toInt(),
      averageSpeed: (json['AverageSpeed'] as num?)?.toDouble(),
      maxSpeed: (json['MaxSpeed'] as num?)?.toDouble(),
      positions: (json['Positions'] as List<dynamic>?)
          ?.map((e) => PositionServer.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$TripToJson(Trip instance) => <String, dynamic>{
      if (instance.id case final value?) '_id': value,
      if (instance.deviceId case final value?) 'DeviceID': value,
      if (instance.startPositionId case final value?) 'StartPositionID': value,
      if (instance.startLat case final value?) 'StartLat': value,
      if (instance.startLon case final value?) 'StartLon': value,
      if (instance.startTime?.toIso8601String() case final value?)
        'StartTime': value,
      if (instance.startOdometer case final value?) 'StartOdometer': value,
      if (instance.endPositionId case final value?) 'EndPositionID': value,
      if (instance.endLat case final value?) 'EndLat': value,
      if (instance.endLon case final value?) 'EndLon': value,
      if (instance.endTime?.toIso8601String() case final value?)
        'EndTime': value,
      if (instance.endOdometer case final value?) 'EndOdometer': value,
      if (instance.distance case final value?) 'Distance': value,
      if (instance.duration case final value?) 'Duration': value,
      if (instance.averageSpeed case final value?) 'AverageSpeed': value,
      if (instance.maxSpeed case final value?) 'MaxSpeed': value,
      if (instance.positions case final value?) 'Positions': value,
    };
