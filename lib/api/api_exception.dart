import 'package:chopper/chopper.dart';
import 'package:smart_tracking/utils/extensions/string_extensions.dart';


class ApiException<T> {
  static int apiErrorResponseCode = 500;

  static ApiException<dynamic> error(Response<dynamic> response) {
    ApiException apiResponse = ApiErrorResponse("error");

    if (!response.isSuccessful) {
      String message;
      if (response.error != null) {
        message = response.error.toString();
      } else {
        message = response.body.toString();
      }

      if (message.isNotEmpty) {
        if (message.isJson()) {
          try {
            var json = message.toJson();
            switch (response.statusCode) {
              case 429:
                apiResponse =
                    ApiErrorUnProcessableEntity("Muchos request");
                break;
              case 426:
                apiResponse = ApiErrorWithCode(json['mssg'].toString(), '426');
                break;
              case 300:
                apiResponse = ApiErrorWithCode(json['mssg'].toString(), '300');
                break;
              case 404:
                if (json['mssg'] != null) {
                  apiResponse =
                      ApiErrorWithCode(json['mssg'].toString(), '404');
                } else {
                  apiResponse = ApiErrorWithCode("not found", '404');
                }
                break;
              case 422:
                if (json['mssg'] != null) {
                  apiResponse = ApiErrorUnProcessableEntity(json['mssg'].toString());
                }
                break;
              case 460:
                apiResponse = ApiErrorWithCode(
                    json['mssg'].toString(), json['errorId'] as String);
                break;
              case 401:
                apiResponse =
                    UnAuthorizedAccessException(json['mssg'].toString());
                break;
              default:
                apiResponse = ApiErrorResponse("Error en servidor");
                break;
            }
          } catch (e) {
            apiResponse = ApiErrorResponse("Error en servidor");
          }
        } else {
          if (response.statusCode == 429) {
            apiResponse = ApiErrorResponse("Muchos request");
          }
        }
      }
    }
    return apiResponse;
  }

  static String? messageErrorResponse(ApiException? exception) {
    String? messageError = '';
    if (exception is ApiErrorUnProcessableEntity) {
      messageError = exception.error;
    } else if (exception is UnAuthorizedAccessException) {
      messageError = exception.error;
    } else if (exception is ApiErrorResponse) {
      messageError = exception.error;
    } else if (exception is ApiErrorSeveralSessions) {
      messageError = exception.error;
    }
    return messageError;
  }
}

class ApiErrorResponse<T> extends ApiException<T> {
  final String? error;
  final int? type;

  ApiErrorResponse([this.error, this.type]);
}

class ApiErrorWithCode<T> extends ApiException<T> {
  final String? error;
  final String? code;

  ApiErrorWithCode([this.error, this.code]);
}

class ApiErrorUnProcessableEntity<T> extends ApiException<T> {
  final String? error;

  ApiErrorUnProcessableEntity([this.error]);
}




class UnAuthorizedAccessException<T> extends ApiException<T> {
  final String? error;

  UnAuthorizedAccessException([this.error]);
}



class ApiErrorSeveralSessions<T> extends ApiException<T> {
  final String? error;

  ApiErrorSeveralSessions([this.error]);
}


class ApiErrorNoOtpCode<T> extends ApiException<T> {
  final String? message;
  final String? messageApp;
  final bool otp;

  ApiErrorNoOtpCode([this.message, this.messageApp, this.otp = false]);
}
