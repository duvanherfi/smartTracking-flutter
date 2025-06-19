// coverage:ignore-file

import 'package:chopper/chopper.dart';
import 'package:flutter/foundation.dart';
import 'package:smart_tracking/api/chopper_http_logging_interceptor.dart';
import 'package:smart_tracking/api/chopper_request_interceptor.dart';
import 'package:smart_tracking/api/model/centroid_geojson.dart';
import 'package:smart_tracking/api/model/geo_fence.dart';
import 'package:smart_tracking/api/model/mssg_response.dart';
import 'package:smart_tracking/api/model/position_server.dart';
import 'package:smart_tracking/api/model/session_response.dart';
import 'package:smart_tracking/api/model/trip.dart';
import 'package:smart_tracking/api/model/user_notification.dart';
import 'package:smart_tracking/api/model/vehicle.dart';
import 'package:smart_tracking/api/model/config_notification.dart';
import 'package:smart_tracking/api/request_json_converter.dart';

import 'package:smart_tracking/api/model/area_geojson.dart';
import 'package:smart_tracking/api/model/session.dart';
import 'package:smart_tracking/api/model/user.dart';


class BaseChopperModule {
  final List<Interceptor> interceptors = [
    const HeadersInterceptor(
      {
        'Accept': 'application/json; charset=UTF-8',
        'Content-Type': 'application/json',
      },
    ),
    ChopperRequestInterceptor(),
    if (!kReleaseMode) CustomHttpLoggingInterceptor(),
  ];
}

final RequestJsonConverter converters = RequestJsonConverter(
  {
    SessionResponse: SessionResponse.fromJson,
    Session: Session.fromJson,
    Vehicle: Vehicle.fromJson,
    GeoFence: GeoFence.fromJson,
    AreaGeoJson: AreaGeoJson.fromJson,
    CentroidGeojson: CentroidGeojson.fromJson,
    User: User.fromJson,
    MssgResponse: MssgResponse.fromJson,
    ConfigNotification: ConfigNotification.fromJson,
    UserNotification: UserNotification.fromJson,
    Trip: Trip.fromJson,
    PositionServer: PositionServer.fromJson,
  },
);

late ErrorConverter errorConverter;

final List<ChopperService> dataSources = [];
