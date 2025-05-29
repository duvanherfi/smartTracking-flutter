import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:smart_tracking/api/api_exception.dart';
import 'package:smart_tracking/api/api_result.dart';
import 'package:smart_tracking/api/model/session.dart';
import 'package:smart_tracking/api/model/session_request.dart';
import 'package:smart_tracking/api/model/session_response.dart';
import 'package:smart_tracking/login/repository/login_repository.dart';
import 'package:smart_tracking/routes.dart';
import 'package:smart_tracking/services/home_services.dart';
import 'package:smart_tracking/utils/app_base_view_model.dart';
import 'package:smart_tracking/utils/app_component.dart';
import 'package:smart_tracking/utils/handle_api_error_dialog.dart';
import 'package:smart_tracking/utils/shared_preferences_v2.dart';


class LoginViewModel extends AppBaseViewModel {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
  final _homeServices = locator<HomeServices>();
  final _sharedPreferencesV2 = locator<SharedPreferencesV2>();
  bool viewModelLoading = false;
  bool isCharging = false;
  final formKey = GlobalKey<FormBuilderState>();
  final numberKey = GlobalKey<FormBuilderFieldState>();
  bool isLoading = false;

  AppLifecycleListener? _listener;

  bool get loading => viewModelLoading;

  LoginViewModel(BuildContext context) {
    generatePushToken();
  }

  @override
  void dispose() {
    _listener?.dispose();
    _listener = null;
    super.dispose();
  }

  void login() async {
    if (formKey.currentState!.validate()) {
      viewModelLoading = true;
      notifyListeners();
      final phone = formKey.currentState?.fields['phone']?.value;
      final password = formKey.currentState?.fields['password']?.value;
      SessionRequest sessionRequest = SessionRequest(
          phone: phone, password: password,
          session: Session(id: '', token: '', pushToken: '${_sharedPreferencesV2.getPushTokenFirebase()}')
      );

      locator<LoginRepository>()
          .login(sessionRequest)
          .then((response) async {
        if (response.status == Status.COMPLETED) {
          final sessionResponse = response.data as SessionResponse;
          await sharedPreferencesV2.setToken(
            sessionResponse.user.token
          );
          await sharedPreferencesV2.setEmail(
            sessionResponse.user.email
          );
          await sharedPreferencesV2.setUserName(
            sessionResponse.user.name
          );
          await sharedPreferencesV2.setUserId(
            sessionResponse.user.id
          );
          await sharedPreferencesV2.setSessionId(
            sessionResponse.user.sessionID
          );
          _homeServices.resetValues();
          appNavigator.pushReplacement(Routes.home);
        } else {
          throw response.apiException as ApiException;
        }
      }).catchError((error) {
        handleApiErrorDialog(error);
      }).whenComplete((){
        viewModelLoading = false;
        notifyListeners();
      });
    }
  }
}
