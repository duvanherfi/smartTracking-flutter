// coverage:ignore-file

import 'dart:async';
import 'package:chopper/chopper.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

String? token;

class ChopperInterceptor implements Interceptor {
  @override
  FutureOr<Response<BodyType>> intercept<BodyType>(
    Chain<BodyType> chain,
  ) async {
    String? token = getSessionToken();

    Request newRequest = chain.request;
    if (token?.isNotEmpty ?? false) {
      newRequest = applyHeader(
        chain.request,
        'Authorization: Bearer',
        token!,
      );
    }

    newRequest.headers['lang'] = "es";

    return chain.proceed(newRequest);
  }


  String? getSessionToken() {
      return token;
  }
}
