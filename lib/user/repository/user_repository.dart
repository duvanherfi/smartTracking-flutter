import 'package:injectable/injectable.dart';
import 'package:smart_tracking/api/api_result.dart';
import 'package:smart_tracking/api/datasources/user_datasource.dart';
import 'package:smart_tracking/api/model/user.dart';
import 'package:smart_tracking/api/repository/app_base_repository.dart';

@injectable
class UserRepository extends AppBaseRepository<UserDataSource> {
  final UserDataSource _dataSource;

  @factoryMethod
  UserRepository.from(this._dataSource) : super.from(_dataSource);

  Future<ApiResult<dynamic>> getUserInfo(String id) {
    return _dataSource.getUserInfo(id).then((value) => value.toApiResult());
  }

  Future<ApiResult<dynamic>> updateUserInfo(User user) {
    return _dataSource.updateUser(user.id, user).then((value) => value.toApiResult());
  }
}
