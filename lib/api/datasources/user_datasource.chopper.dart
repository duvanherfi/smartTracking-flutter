// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_datasource.dart';

// **************************************************************************
// ChopperGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
final class _$UserDataSource extends UserDataSource {
  _$UserDataSource([ChopperClient? client]) {
    if (client == null) return;
    this.client = client;
  }

  @override
  final Type definitionType = UserDataSource;

  @override
  Future<Response<SessionResponse>> getUserInfo(String id) {
    final Uri $url = Uri.parse('/users/${id}');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<SessionResponse, SessionResponse>($request);
  }

  @override
  Future<Response<SessionResponse>> updateUser(
    String id,
    User user,
  ) {
    final Uri $url = Uri.parse('/users/${id}');
    final $body = user;
    final Request $request = Request(
      'PUT',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<SessionResponse, SessionResponse>($request);
  }

  @override
  Future<Response<MssgResponse>> recoveryPassword(Map<String, dynamic> body) {
    final Uri $url = Uri.parse('/users/recovery_password');
    final $body = body;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<MssgResponse, MssgResponse>($request);
  }
}
