import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:chopper/chopper.dart';
import 'package:smart_tracking/api/model/sesion.dart';
import 'package:smart_tracking/api/model/session_response.dart';
import 'package:smart_tracking/api/model/vehicle.dart';

part 'vehicle_datasource.chopper.dart';

@ChopperApi(baseUrl: "/vehicles")
abstract class VehicleDataSource extends ChopperService {
  @GET()
  Future<Response<List<Vehicle>>> getVehicles();

  static _$VehicleDataSource create([ChopperClient? client]) =>
      _$VehicleDataSource(client);
}
