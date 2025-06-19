import 'package:injectable/injectable.dart';
import 'package:smart_tracking/api/api_result.dart';
import 'package:smart_tracking/api/datasources/notification_datasource.dart';
import 'package:smart_tracking/api/model/config_notification.dart';
import 'package:smart_tracking/api/repository/app_base_repository.dart';

@injectable
class NotificationsRepository extends AppBaseRepository<NotificationDataSource> {
  final NotificationDataSource _dataSource;

  @factoryMethod
  NotificationsRepository.from(this._dataSource) : super.from(_dataSource);

  Future<ApiResult<List<ConfigNotification>>> getNotifications() {
    return _dataSource.getNotifications().then((value) {
      return value.toApiResult();
    });
  }

  Future<ApiResult<ConfigNotification>> toggle_enabled(ConfigNotification notification) {
    return _dataSource.toggle_enabled(notification.id!).then((value) {
      return value.toApiResult();
    });
  }
}
