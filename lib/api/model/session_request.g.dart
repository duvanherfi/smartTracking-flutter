// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'session_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SessionRequest _$SessionRequestFromJson(Map<String, dynamic> json) =>
    SessionRequest(
      session: Session.fromJson(json['session'] as Map<String, dynamic>),
      phone: json['phone'] as String?,
      password: json['password'] as String?,
    );

Map<String, dynamic> _$SessionRequestToJson(SessionRequest instance) =>
    <String, dynamic>{
      if (instance.phone case final value?) 'phone': value,
      if (instance.password case final value?) 'password': value,
      'session': instance.session,
    };
