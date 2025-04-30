import 'package:flutter/cupertino.dart';
import 'package:injectable/injectable.dart';
import 'package:smart_tracking/api/api_result.dart';
import 'package:smart_tracking/api/datasources/vehicle_datasource.dart';
import 'package:smart_tracking/api/model/vehicle.dart';
import 'package:smart_tracking/api/repository/app_base_repository.dart';

@injectable
class VehicleRepository extends AppBaseRepository<VehicleDataSource> {
  final VehicleDataSource _dataSource;

  @factoryMethod
  VehicleRepository.from(this._dataSource) : super.from(_dataSource);

  Future<ApiResult<List<Vehicle>>> getVehicles() {
    return _dataSource.getVehicles().then((value) {
      return value.toApiResult();
    });
  }
}
