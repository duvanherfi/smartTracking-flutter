import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:smart_tracking/remember_password/view_model/recovery_password_view_model.dart';
import 'package:smart_tracking/routes.dart';
import 'package:smart_tracking/utils/app_component.dart';
import 'package:stacked/stacked.dart';

class RemeberPasswordScreen extends StackedView<RecoveryPasswordViewModel> {

  @override
  Widget builder(BuildContext context, RecoveryPasswordViewModel viewModel, Widget? child) {
    return Scaffold(
      key: viewModel.scaffoldKey,
      appBar: AppBar(
          title: const Text('Recordar contraseña', style: TextStyle(color: Colors.white)),
          backgroundColor: const Color(0xFF6c18db),
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_circle_left,
              color: Colors.white,
              size: 45,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          )
      ),
      resizeToAvoidBottomInset: false,
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/background.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Container(
          decoration: BoxDecoration(
            color: const Color(0xFF18BEDB).withOpacity(0.88),
          ),
          child: Stack(
            alignment: Alignment.center,
            children: [
              Positioned(
                  top: -200,
                  child: Container(
                    width: 640,
                    height: 521,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/images/header.png'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  )
              ),
              const Positioned(
                  top: 90,
                  child: Image(
                    image: AssetImage('assets/images/icon.png'),
                  )
              ),
              Container(
                alignment: Alignment.center,
                color: Colors.transparent,
                margin: const EdgeInsets.only(top: 390),
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Center(
                  child: FormBuilder(
                    key: viewModel.formKey,
                    child: Column(
                      children: [
                        FormBuilderTextField(
                          keyboardType: TextInputType.number,
                          name: 'phone',
                          style: const TextStyle(
                              color: Colors.black,
                              height: 1
                          ),
                          decoration: const InputDecoration(
                            labelText: 'Número',
                            floatingLabelBehavior: FloatingLabelBehavior.never,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(30)),
                              borderSide: BorderSide.none,
                            ),
                            filled: true,
                            fillColor: Colors.white,
                            prefixIcon: Icon(
                              Icons.numbers,
                              color: Colors.grey,
                            ),
                          ),
                          validator: FormBuilderValidators.compose([
                            FormBuilderValidators.required(
                              errorText: 'El campo no debe estar vacío',
                            ),
                            FormBuilderValidators.numeric(
                              errorText: 'El número de teléfono debe ser numérico',
                            ),
                          ]),
                        ),
                        const SizedBox(height: 30),
                        MaterialButton(
                          color: const Color(0xFF6C18DB),
                          textColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          height: 50,
                          minWidth: double.infinity,
                          onPressed: viewModel.recoveryPassword,
                          child: const Text('Recordar contraseña'),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  RecoveryPasswordViewModel viewModelBuilder(BuildContext context) =>
      RecoveryPasswordViewModel();
}