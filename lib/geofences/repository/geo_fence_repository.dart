import 'package:injectable/injectable.dart';
import 'package:smart_tracking/api/api_result.dart';
import 'package:smart_tracking/api/datasources/geo_fence_datasource.dart';
import 'package:smart_tracking/api/model/geo_fence.dart';
import 'package:smart_tracking/api/model/mssg_response.dart';
import 'package:smart_tracking/api/repository/app_base_repository.dart';

@injectable
class GeoFenceRepository extends AppBaseRepository<GeoFenceDataSource> {
  final GeoFenceDataSource _dataSource;

  @factoryMethod
  GeoFenceRepository.from(this._dataSource) : super.from(_dataSource);

  Future<ApiResult<List<GeoFence>>> getGeoFences() {
    return _dataSource.getGeoFences().then((value) {
      return value.toApiResult();
    });
  }

  Future<ApiResult<GeoFence>> createGeoFence(Map<String, GeoFence> body) {
    return _dataSource.createGeoFence(body).then((value) {
      return value.toApiResult();
    });
  }

  Future<ApiResult<GeoFence>> updateGeoFence(String id, Map<String, GeoFence> body) {
    return _dataSource.updateGeoFence(id, body).then((value) {
      return value.toApiResult();
    });
  }

  Future<ApiResult<MssgResponse>> deleteGeoFence(String id) {
    return _dataSource.deleteGeoFence(id).then((value) {
      return value.toApiResult();
    });
  }
}
