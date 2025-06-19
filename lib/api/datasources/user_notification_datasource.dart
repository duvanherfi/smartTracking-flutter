import 'package:chopper/chopper.dart';
import 'package:smart_tracking/api/model/user_notification.dart';

part 'user_notification_datasource.chopper.dart';

@ChopperApi(baseUrl: "/user_notifications")
abstract class UserNotificationDataSource extends ChopperService {

  @GET()
  Future<Response<List<UserNotification>>> getUserNotifications();

  static _$UserNotificationDataSource create([ChopperClient? client]) =>
      _$UserNotificationDataSource(client);
}
