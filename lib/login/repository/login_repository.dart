import 'package:injectable/injectable.dart';
import 'package:smart_tracking/api/api_result.dart';
import 'package:smart_tracking/api/api_exception.dart';
import 'package:smart_tracking/api/datasources/login_datasource.dart';
import 'package:smart_tracking/api/model/sesion.dart';

import 'package:smart_tracking/api/repository/app_base_repository.dart';

@injectable
class LoginRepository extends AppBaseRepository<LoginDataSource> {
  final LoginDataSource _dataSource;

  @factoryMethod
  LoginRepository.from(this._dataSource) : super.from(_dataSource);

  Future<ApiResult<dynamic>> login(Session request) {
    return _dataSource.login(request).then((value) => value.toApiResult());
  }
}
