import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:smart_tracking/login/view_model/login_view_model.dart';
import 'package:stacked/stacked.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:smart_tracking/routes.dart';
import 'package:smart_tracking/utils/app_component.dart';

import 'package:smart_tracking/widgets/splash_widget.dart';

class LoginScreen extends StackedView<LoginViewModel> {
  const LoginScreen({super.key});

  @override
  Widget builder(BuildContext context, LoginViewModel viewModel, Widget? child) =>
      (viewModel.loading)
      ? const SplashWidget()
      : loginWidget(context);

  @override
  LoginViewModel viewModelBuilder(BuildContext context) => LoginViewModel(context);

  Widget loginWidget(BuildContext context) {
    final Uri terms = Uri.parse('https://www.google.com.co');

    Future<void> _launchUrl() async {
      if (!await launchUrl(terms)) {
        throw Exception('Could not launch $terms');
      }
    }

    return ViewModelBuilder<LoginViewModel>.nonReactive(
      viewModelBuilder: () => LoginViewModel(context),
      builder: (context, viewModel, child) {
        return Scaffold(
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
                              key: viewModel.numberKey,
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
                            const SizedBox(height: 15),
                            FormBuilderTextField(
                              name: 'password',
                              style: const TextStyle(
                                  color: Colors.black,
                                  height: 1
                              ),
                              decoration: const InputDecoration(
                                labelText: 'Contraseña',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(30)),
                                  borderSide: BorderSide.none,
                                ),
                                floatingLabelBehavior: FloatingLabelBehavior.never,
                                filled: true,
                                fillColor: Colors.white,
                                prefixIcon: const Icon(
                                  Icons.lock,
                                  color: Colors.grey,
                                ),
                              ),
                              obscureText: true,
                              validator: FormBuilderValidators.compose([
                                FormBuilderValidators.required(
                                  errorText: 'El campo no debe estar vacío',
                                ),
                              ]),
                            ),
                            const SizedBox(height: 15),
                            FormBuilderCheckbox(
                              name: 'accept_terms',
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              side: const BorderSide(
                                width: 1,
                                color: Colors.white,
                                strokeAlign: 1,
                              ),
                              contentPadding: EdgeInsets.zero,
                              title: RichText(
                                  textAlign: TextAlign.center,
                                  text: TextSpan(
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 15,
                                    ),
                                    children: [
                                      TextSpan(
                                          text: 'Acepto los términos y condiciones',
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                          children: [
                                            TextSpan(
                                              text: ' presiona aquí para verlos',
                                              style: const TextStyle(
                                                decoration: TextDecoration.underline,
                                                decorationColor: Colors.grey,
                                              ),
                                              recognizer: TapGestureRecognizer()..onTap = () {
                                                _launchUrl();
                                              },
                                            ),
                                          ]
                                      ),
                                    ],
                                  )
                              ),
                              checkColor: Color(0xFF6C18DB),
                              activeColor: Colors.white,
                              visualDensity: VisualDensity.compact,
                              decoration: const InputDecoration(
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(40)),
                                  borderSide: BorderSide(color: Colors.white),
                                ),
                                isCollapsed: true,
                              ),
                              validator: FormBuilderValidators.compose([
                                FormBuilderValidators.required(
                                  errorText: 'Debes aceptar los términos y condiciones',
                                ),
                              ]),
                            ),
                            const SizedBox(height: 15),
                            MaterialButton(
                              color: const Color(0xFF6C18DB),
                              textColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                              height: 50,
                              minWidth: double.infinity,
                              onPressed: ()=> viewModel.login(),
                              child: const Text('Iniciar sesión'),
                            ),
                            const SizedBox(height: 10),
                            MaterialButton(
                              textColor: Colors.white,
                              height: 30,
                              onPressed: () {
                                appNavigator.push(Routes.rememberPassword);
                              },
                              child: const Text(
                                  '¿Olvidaste tu contraseña?',
                                  style: TextStyle(
                                    fontSize: 16,
                                  )
                              ),

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
    );
  }
}
