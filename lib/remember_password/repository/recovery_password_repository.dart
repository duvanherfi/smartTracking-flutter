import 'package:injectable/injectable.dart';
import 'package:smart_tracking/api/api_result.dart';
import 'package:smart_tracking/api/datasources/user_datasource.dart';
import 'package:smart_tracking/api/repository/app_base_repository.dart';

@injectable
class RecoveryPasswordRepository extends AppBaseRepository<UserDataSource> {
  final UserDataSource _dataSource;

  @factoryMethod
  RecoveryPasswordRepository.from(this._dataSource) : super.from(_dataSource);

  Future<ApiResult<dynamic>> recoveryPassword(int phone) {
    return _dataSource.recoveryPassword({
      'phone': phone,
    }).then((value) => value.toApiResult());
  }
}
