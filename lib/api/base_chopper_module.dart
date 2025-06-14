// coverage:ignore-file

import 'package:chopper/chopper.dart';
import 'package:flutter/foundation.dart';
import 'package:smart_tracking/api/chopper_http_logging_interceptor.dart';
import 'package:smart_tracking/api/chopper_request_interceptor.dart';
import 'package:smart_tracking/api/model/centroid_geojson.dart';
import 'package:smart_tracking/api/model/geo_fence.dart';
import 'package:smart_tracking/api/model/mssg_response.dart';
import 'package:smart_tracking/api/model/session_response.dart';
import 'package:smart_tracking/api/model/vehicle.dart';
import 'package:smart_tracking/api/model/config_notification.dart';
import 'package:smart_tracking/api/request_json_converter.dart';

import 'model/area_geojson.dart';
import 'model/session.dart';
import 'model/user.dart';


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
  },
);

late ErrorConverter errorConverter;

final List<ChopperService> dataSources = [];
