

import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:smart_tracking/api/api_exception.dart';
import 'package:smart_tracking/api/api_result.dart';
import 'package:smart_tracking/api/model/session_response.dart';
import 'package:smart_tracking/services/home_services.dart';
import 'package:smart_tracking/user/repository/user_repository.dart';
import 'package:smart_tracking/utils/app_base_view_model.dart';
import 'package:smart_tracking/utils/app_component.dart';
import 'package:smart_tracking/utils/extensions/dialog.extension.dart';

class UserViewModel extends AppBaseViewModel {
  final _homeServices = locator<HomeServices>();
  final userRepository = locator<UserRepository>();
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
  final formKey = GlobalKey<FormBuilderState>();
  bool loading = false;

  get user => _homeServices.user.value;

  void updateFields() {
    if (formKey.currentState?.saveAndValidate() ?? false) {
      loading = true;
      notifyListeners();
      userRepository.updateUserInfo(user).then((response) {
        if (response.status == Status.COMPLETED) {
          SessionResponse sessionResponse = response.data as SessionResponse;
          _homeServices.user.value = sessionResponse.user;
          showPiDialog(
              "Información de usuario actualizada correctamente"
          );
        } else {
          throw response.apiException as ApiException;
        }
      }).catchError((error) {
        loading = false;
        notifyListeners();
        throw error;
      }).whenComplete((){
        loading = false;
        notifyListeners();
      });
    }
  }

}