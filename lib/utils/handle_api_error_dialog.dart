import 'dart:async';
import 'package:get_it/get_it.dart';
import 'package:smart_tracking/utils/shared_preferences_v2.dart';
import 'package:smart_tracking/utils/app_component.dart';

import 'package:smart_tracking/api/api_exception.dart';
import 'package:smart_tracking/routes.dart';

import 'extensions/dialog.extension.dart';

FutureOr<dynamic> handleApiErrorDialog(
    ApiException<dynamic>? exception, {
      Function()? click,
      Function()? socialRegister,
    }) async {
  if (exception != null) {
    if (exception is UnAuthorizedAccessException) {
      final token = await sharedPreferencesV2.getToken();
      if (token != null) {
        sharedPreferencesV2.clearData();
        appNavigator.pushNamedAndRemoveUntil(Routes.login);
      }
    } else if (exception is ApiErrorUnProcessableEntity) {
      showPiDialog(
        exception.error!,
        onAcceptEvent: (_) => click?.call(),
      );
    } else if (exception is ApiErrorSeveralSessions) {
      showPiDialog(
        exception.error!,
        onAcceptEvent: (_) => click?.call(),
      );
    } else if (exception is ApiErrorResponse) {
      showPiDialog(
        exception.error!,
        onAcceptEvent: (_) => click?.call(),
      );
    }
  } else {
    showPiDialog(
      exception.toString(),
      onAcceptEvent: (_) => click?.call(),
    );
  }
}