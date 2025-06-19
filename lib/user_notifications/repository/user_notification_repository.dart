import 'package:injectable/injectable.dart';
import 'package:smart_tracking/api/api_result.dart';
import 'package:smart_tracking/api/datasources/user_notification_datasource.dart';
import 'package:smart_tracking/api/model/user_notification.dart';
import 'package:smart_tracking/api/repository/app_base_repository.dart';

@injectable
class UserNotificationRepository extends AppBaseRepository<UserNotificationDataSource> {
  final UserNotificationDataSource _dataSource;

  @factoryMethod
  UserNotificationRepository.from(this._dataSource) : super.from(_dataSource);

  Future<ApiResult<List<UserNotification>>> getUserNotifications() {
    return _dataSource.getUserNotifications().then((value) {
      return value.toApiResult();
    });
  }
}
