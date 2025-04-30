import 'package:smart_tracking/api/api_exception.dart';

extension ApiResultExtension on ApiResult {
  bool get completed => status == Status.COMPLETED;
}

class ApiResult<T> {
  Status status;
  int? statusCode;
  T? data;
  ApiException? apiException;

  ApiResult.complete(
    this.data, {
    this.statusCode,
  }) : status = Status.COMPLETED;

  ApiResult.error(
    this.apiException, {
    this.statusCode,
  }) : status = Status.ERROR;
}

enum Status { COMPLETED, ERROR }
