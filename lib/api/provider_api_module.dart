import 'package:chopper/chopper.dart';
import 'package:injectable/injectable.dart';
import 'package:smart_tracking/api/datasources/geo_fence_datasource.dart';
import 'package:smart_tracking/api/datasources/login_datasource.dart';
import 'package:smart_tracking/api/datasources/session_datasource.dart';
import 'package:smart_tracking/api/datasources/user_datasource.dart';
import 'package:smart_tracking/api/datasources/vehicle_datasource.dart';

@module
abstract class ProviderApiModule {
  LoginDataSource provideLoginDataSource(ChopperClient client) =>
      client.getService<LoginDataSource>();
  VehicleDataSource provideVehicleDataSource(ChopperClient client) =>
      client.getService<VehicleDataSource>();
  GeoFenceDataSource provideGeoFenceDataSource(ChopperClient client) =>
      client.getService<GeoFenceDataSource>();
  UserDataSource provideUserDataSource(ChopperClient client) =>
      client.getService<UserDataSource>();
  SessionDataSource provideSessionDataSource(ChopperClient client) =>
      client.getService<SessionDataSource>();
}
