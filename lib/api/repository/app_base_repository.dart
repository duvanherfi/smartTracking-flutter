import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:smart_tracking/utils/app_component.dart';
import 'package:chopper/chopper.dart';
import 'package:smart_tracking/api/api_result.dart';
import 'package:smart_tracking/api/api_exception.dart';
import 'package:http/http.dart' as http;

abstract class AppBaseRepository<T> {
  late final T datasource;

  @mustCallSuper
  AppBaseRepository.from(this.datasource);
}

extension ResponseToapiResult<BodyType> on Response<BodyType> {
  ApiResult<BodyType> toApiResult() {
    if (error is ApiException) {
      return ApiResult.error(
        error as ApiException,
        statusCode: statusCode,
      );
    } else if (error is http.ClientException || error is SocketException) {
      return ApiResult.error(
        ApiErrorUnProcessableEntity(
          "No hemos podido conectarnos, por favor revisa tu conexión a Internet.",
        ),
        statusCode: 422,
      );
    }
    return ApiResult.complete(
      this.body,
      statusCode: statusCode,
    );
  }
}
