import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormBuilderState>();
  final _numberKey = GlobalKey<FormBuilderFieldState>();

  void _login() {
    final email = _emailController.text;
    final password = _passwordController.text;

    // Aquí puedes agregar la lógica para autenticar al usuario
    print('Email: $email');
    print('Password: $password');
    // Navegar a la pantalla principal después del login exitoso
    Navigator.pushReplacementNamed(context, '/home');
  }

  @override
  Widget build(BuildContext context) {

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
                    key: _formKey,
                    child: Column(
                      children: [
                        FormBuilderTextField(
                          key: _numberKey,
                          keyboardType: TextInputType.number,
                          name: 'phone',
                          style: const TextStyle(
                              color: Colors.black,
                              height: 1
                          ),
                          decoration: InputDecoration(
                            labelText: 'Número',
                            floatingLabelBehavior: FloatingLabelBehavior.never,
                            border: const OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(30)),
                              borderSide: BorderSide.none,
                            ),
                            filled: true,
                            fillColor: Colors.white,
                            prefixIcon: const Icon(
                              Icons.numbers,
                              color: Colors.grey,
                            ),
                          ),
                          validator: FormBuilderValidators.compose([
                            FormBuilderValidators.required(),
                            FormBuilderValidators.email(),
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
                            labelText: 'Constraseña',
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
                            FormBuilderValidators.required(),
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
                                        print('launch url');
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
}