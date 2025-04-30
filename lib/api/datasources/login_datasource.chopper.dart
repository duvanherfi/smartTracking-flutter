// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_datasource.dart';

// **************************************************************************
// ChopperGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
final class _$LoginDataSource extends LoginDataSource {
  _$LoginDataSource([ChopperClient? client]) {
    if (client == null) return;
    this.client = client;
  }

  @override
  final Type definitionType = LoginDataSource;

  @override
  Future<Response<SessionResponse>> login(Session request) {
    final Uri $url = Uri.parse('/sessions/login');
    final $body = request;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<SessionResponse, SessionResponse>($request);
  }
}
