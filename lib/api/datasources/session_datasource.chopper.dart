// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'session_datasource.dart';

// **************************************************************************
// ChopperGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
final class _$SessionDataSource extends SessionDataSource {
  _$SessionDataSource([ChopperClient? client]) {
    if (client == null) return;
    this.client = client;
  }

  @override
  final Type definitionType = SessionDataSource;

  @override
  Future<Response<SessionResponse>> updateSession(
    String id,
    Session session,
  ) {
    final Uri $url = Uri.parse('/sessions/${id}');
    final $body = session;
    final Request $request = Request(
      'PUT',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<SessionResponse, SessionResponse>($request);
  }
}
