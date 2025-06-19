import 'package:injectable/injectable.dart';
import 'package:smart_tracking/api/api_result.dart';
import 'package:smart_tracking/api/datasources/report_datasource.dart';
import 'package:smart_tracking/api/model/trip.dart';
import 'package:smart_tracking/api/repository/app_base_repository.dart';

@injectable
class ReportRepository extends AppBaseRepository<ReportDataSource> {
  final ReportDataSource _dataSource;

  @factoryMethod
  ReportRepository.from(this._dataSource) : super.from(_dataSource);

  Future<ApiResult<List<Trip>>> getTravels(
      String vehicleId,
      String from,
      String to
  ) {
    return _dataSource.getTravels(
      vehicleId,
      from,
      to,
    ).then((value) {
      return value.toApiResult();
    });
  }
}
