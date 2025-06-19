// coverage:ignore-file

import 'dart:async';

import 'package:chopper/chopper.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:smart_tracking/utils/app_component.dart';
import 'package:smart_tracking/utils/shared_preferences_v2.dart';

class ChopperRequestInterceptor implements Interceptor {
  @override
  FutureOr<Response<BodyType>> intercept<BodyType>(
    Chain<BodyType> chain,
  ) async {
    String? token = await locator<SharedPreferencesV2>().getToken();
    chain.request.headers['Authorization'] = 'Bearer $token';
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    chain.request.headers['lang'] = 'es';
    final Response<BodyType> response = await chain.proceed(
      applyHeader(chain.request, 'build', packageInfo.buildNumber),
    );
    return response;
  }
}
