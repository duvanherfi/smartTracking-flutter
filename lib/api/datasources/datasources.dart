import 'package:chopper/chopper.dart';
import 'package:smart_tracking/api/datasources/geo_fence_datasource.dart';
import 'package:smart_tracking/api/datasources/login_datasource.dart';
import 'package:smart_tracking/api/datasources/vehicle_datasource.dart';
final List<ChopperService> chopperDataSources = [
  LoginDataSource.create(),
  VehicleDataSource.create(),
  GeoFenceDataSource.create(),
];
