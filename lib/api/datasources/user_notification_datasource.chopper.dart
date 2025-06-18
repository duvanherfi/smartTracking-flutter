// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_notification_datasource.dart';

// **************************************************************************
// ChopperGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
final class _$UserNotificationDataSource extends UserNotificationDataSource {
  _$UserNotificationDataSource([ChopperClient? client]) {
    if (client == null) return;
    this.client = client;
  }

  @override
  final Type definitionType = UserNotificationDataSource;

  @override
  Future<Response<List<UserNotification>>> getUserNotifications() {
    final Uri $url = Uri.parse('/user_notifications');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<List<UserNotification>, UserNotification>($request);
  }
}
