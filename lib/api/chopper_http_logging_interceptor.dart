// coverage:ignore-file

import 'dart:async';
import 'dart:developer';

import 'package:chopper/chopper.dart';
import 'package:http/http.dart' as http;
import 'package:meta/meta.dart';

@immutable
class CustomHttpLoggingInterceptor implements HttpLoggingInterceptor {
  final Map<String, DateTime> _requestHashCodeToDateTime = {};

  @override
  Level get level => Level.body;

  @override
  FutureOr<Response<BodyType>> intercept<BodyType>(
    Chain<BodyType> chain,
  ) async {
    final request = chain.request;
    final base = await request.toBaseRequest();
    if (base is http.Request) {
      final body = base.body;

      var headers = StringBuffer();
      base.headers.forEach((k, v) => headers.write(' $k: $v'));

      var bytes = '0';

      if (body.isNotEmpty) {
        bytes = ' (${base.bodyBytes.length}-byte body)';
      }

      var message = 'Request -> method 🥳 -> ${base.method}\n'
          '-> url 🥳 -> ${base.url}'
          '\n'
          '-> headers 🐶 -> ${headers.toString()}'
          '\n'
          '-> body -> 🤪 \n$body\n '
          '\n'
          '--> END 🤪 ${base.method}$bytes';
      log(message);
    }

    // add hashCode -> requestTime entry to map
    final requestTime = DateTime.now();
    _requestHashCodeToDateTime[base.url.path] = requestTime;

    final response = await chain.proceed(request);
    if (response.base is http.Response) {
      final resp = response.base as http.Response;
      if (resp.body.isNotEmpty) {
        var bytes = ' (${response.bodyBytes.length}-byte body)';
        var headers = StringBuffer();
        response.base.headers.forEach((k, v) => headers.write(' $k: $v'));

        // Determine and log the call duration
        final hashCode = request.url.path;
        final responseTime = DateTime.now();
        int? durationInMillis;
        if (_requestHashCodeToDateTime.containsKey(hashCode)) {
          final requestTime = _requestHashCodeToDateTime[hashCode];
          durationInMillis =
              requestTime?.difference(responseTime).inMilliseconds.abs();
          _requestHashCodeToDateTime.remove(hashCode);
        }

        var message = 'Response -> status code 🤔 -> ${response.statusCode}\n'
            '-> url 🥳 -> ${request.url}'
            '\n'
            '-> headers 🐶 -> ${headers.toString()}'
            '\n'
            '-> response -> 😲 \n${resp.body}\n '
            '\n'
            '-> duration -> ⏱️ -> $durationInMillis ms\n'
            '-> duration -> ⏱️ -> ${resp.headers['x-runtime']} ms\n'
            '\n'
            '--> END 🤪 ${request.method}$bytes';
        log(message);
      }
    }

    return response;
  }

  @override
  bool get onlyErrors => false;
}
