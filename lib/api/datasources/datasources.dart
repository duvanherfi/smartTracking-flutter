import 'package:chopper/chopper.dart';
import 'package:smart_tracking/api/datasources/geo_fence_datasource.dart';
import 'package:smart_tracking/api/datasources/login_datasource.dart';
import 'package:smart_tracking/api/datasources/notification_datasource.dart';
import 'package:smart_tracking/api/datasources/report_datasource.dart';
import 'package:smart_tracking/api/datasources/session_datasource.dart';
import 'package:smart_tracking/api/datasources/user_datasource.dart';
import 'package:smart_tracking/api/datasources/user_notification_datasource.dart';
import 'package:smart_tracking/api/datasources/vehicle_datasource.dart';

final List<ChopperService> chopperDataSources = [
  LoginDataSource.create(),
  VehicleDataSource.create(),
  GeoFenceDataSource.create(),
  UserDataSource.create(),
  SessionDataSource.create(),
  NotificationDataSource.create(),
  UserNotificationDataSource.create(),
  ReportDataSource.create(),
];
