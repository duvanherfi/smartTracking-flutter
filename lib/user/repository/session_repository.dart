import 'package:injectable/injectable.dart';
import 'package:smart_tracking/api/api_result.dart';
import 'package:smart_tracking/api/datasources/session_datasource.dart';
import 'package:smart_tracking/api/model/session.dart';

import 'package:smart_tracking/api/repository/app_base_repository.dart';

@injectable
class SessionRepository extends AppBaseRepository<SessionDataSource> {
  final SessionDataSource _dataSource;

  @factoryMethod
  SessionRepository.from(this._dataSource) : super.from(_dataSource);

  Future<ApiResult<dynamic>> updateSession(Session session) {
    return _dataSource.updateSession(
        session.id, session
    ).then((value) => value.toApiResult());
  }
}
