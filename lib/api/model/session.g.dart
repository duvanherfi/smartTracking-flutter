// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'session.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Session _$SessionFromJson(Map<String, dynamic> json) => Session(
      id: json['_id'] as String,
      token: json['token'] as String,
      pushToken: json['push_token'] as String,
    );

Map<String, dynamic> _$SessionToJson(Session instance) => <String, dynamic>{
      '_id': instance.id,
      'token': instance.token,
      'push_token': instance.pushToken,
    };
