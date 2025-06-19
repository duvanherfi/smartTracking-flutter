import 'package:chopper/chopper.dart';
import 'package:smart_tracking/api/model/area_geojson.dart';
import 'package:smart_tracking/api/model/vehicle.dart';

part 'vehicle_datasource.chopper.dart';

@ChopperApi(baseUrl: "/vehicles")
abstract class VehicleDataSource extends ChopperService {
  @GET()
  Future<Response<List<Vehicle>>> getVehicles();

  @GET(path: "{id}/recommended")
  Future<Response<AreaGeoJson>> getRecommended(@Path("id") String vehicleId);

  static _$VehicleDataSource create([ChopperClient? client]) =>
      _$VehicleDataSource(client);
}
