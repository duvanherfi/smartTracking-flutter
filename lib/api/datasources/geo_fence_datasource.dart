import 'package:chopper/chopper.dart';
import 'package:smart_tracking/api/model/geo_fence.dart';

part 'geo_fence_datasource.chopper.dart';

@ChopperApi(baseUrl: "/geo_fences")
abstract class GeoFenceDataSource extends ChopperService {
  @GET()
  Future<Response<List<GeoFence>>> getGeoFences();

  static _$GeoFenceDataSource create([ChopperClient? client]) =>
      _$GeoFenceDataSource(client);
}
