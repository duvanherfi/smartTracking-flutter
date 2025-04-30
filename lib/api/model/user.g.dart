// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) => User(
      id: json['_id'] as String,
      createdAt: DateTime.parse(json['created_at'] as String),
      email: json['email'] as String,
      isActive: json['is_active'] as bool,
      name: json['name'] as String,
      phone: json['phone'] as String,
      updatedAt: DateTime.parse(json['updated_at'] as String),
      token: json['token'] as String,
    );

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      '_id': instance.id,
      'created_at': instance.createdAt.toIso8601String(),
      'email': instance.email,
      'is_active': instance.isActive,
      'name': instance.name,
      'phone': instance.phone,
      'updated_at': instance.updatedAt.toIso8601String(),
      'token': instance.token,
    };
