

import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:smart_tracking/api/api_exception.dart';
import 'package:smart_tracking/api/api_result.dart';
import 'package:smart_tracking/api/model/mssg_response.dart';
import 'package:smart_tracking/remember_password/repository/recovery_password_repository.dart';
import 'package:smart_tracking/utils/app_base_view_model.dart';
import 'package:smart_tracking/utils/app_component.dart';
import 'package:smart_tracking/utils/handle_api_error_dialog.dart';

import '../../routes.dart';

class RecoveryPasswordViewModel extends AppBaseViewModel {
  final _recoveryPasswordRepository = locator<RecoveryPasswordRepository>();
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
  final formKey = GlobalKey<FormBuilderState>();
  bool loading = false;

  Future<void> recoveryPassword() async {
    if (formKey.currentState?.saveAndValidate() ?? false) {
      loading = true;
      notifyListeners();
      final phone = formKey.currentState?.fields['phone']?.value;
      _recoveryPasswordRepository.recoveryPassword(int.parse(phone)).then((response) async{
        if (response.status == Status.COMPLETED) {
          final result = response.data as MssgResponse;
          showDialog(
            context: scaffoldKey.currentContext!,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text(
                  textAlign: TextAlign.center,
                  'Contraseña recordada',
                  style: TextStyle(
                    color: Color(0xFF6C18DB),
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                  ),
                ),
                content: Text(
                  textAlign: TextAlign.justify,
                  result.mssg ?? "",
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                  ),
                ),
                actions: <Widget>[
                  TextButton(
                    child: const Text('Aceptar'),
                    onPressed: () {
                      // Lógica para aceptar
                      appNavigator.pushNamedAndRemoveUntil(Routes.login);
                    },
                  ),
                ],
              );
            },
          );
        } else {
          throw response.apiException as ApiException;
        }
      }).catchError((error) {
        loading = false;
        notifyListeners();
        handleApiErrorDialog(error);
      }).whenComplete((){
        loading = false;
        notifyListeners();
      });
    }
  }

}