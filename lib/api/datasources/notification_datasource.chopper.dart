// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification_datasource.dart';

// **************************************************************************
// ChopperGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
final class _$NotificationDataSource extends NotificationDataSource {
  _$NotificationDataSource([ChopperClient? client]) {
    if (client == null) return;
    this.client = client;
  }

  @override
  final Type definitionType = NotificationDataSource;

  @override
  Future<Response<List<ConfigNotification>>> getNotifications() {
    final Uri $url = Uri.parse('/notifications');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<List<ConfigNotification>, ConfigNotification>($request);
  }

  @override
  Future<Response<ConfigNotification>> toggle_enabled(String id) {
    final Uri $url = Uri.parse('/notifications/${id}/toggle_enabled');
    final Request $request = Request(
      'PUT',
      $url,
      client.baseUrl,
    );
    return client.send<ConfigNotification, ConfigNotification>($request);
  }
}
