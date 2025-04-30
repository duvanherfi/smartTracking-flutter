import 'dart:async';

import 'package:chopper/chopper.dart';
import 'package:smart_tracking/api/api_exception.dart';

class RequestJsonErrorConverter implements ErrorConverter {
  @override
  FutureOr<Response> convertError<BodyType, InnerType>(Response response) {
    ApiException newResponse = ApiException.error(response);
    return response.copyWith(bodyError: newResponse);
  }
}
