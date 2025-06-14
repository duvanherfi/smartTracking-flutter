import 'package:chopper/chopper.dart';
import 'package:smart_tracking/api/model/config_notification.dart';

part 'notification_datasource.chopper.dart';

@ChopperApi(baseUrl: "/notifications")
abstract class NotificationDataSource extends ChopperService {

  @GET()
  Future<Response<List<ConfigNotification>>> getNotifications();

  @PUT(path: "{id}/toggle_enabled")
  Future<Response<ConfigNotification>> toggle_enabled(
    @Path("id") String id,
  );

  static _$NotificationDataSource create([ChopperClient? client]) =>
      _$NotificationDataSource(client);
}
