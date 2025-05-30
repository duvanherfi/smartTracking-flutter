import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:smart_tracking/user/view_model/user_view_model.dart';
import 'package:smart_tracking/utils/app_component.dart';
import 'package:smart_tracking/widgets/splash_widget.dart';
import 'package:stacked/stacked.dart';

class UserScreen extends StackedView<UserViewModel> {
  const UserScreen({super.key});

  @override
  Widget builder(BuildContext context, UserViewModel viewModel, Widget? child) =>
      (viewModel.loading)
      ? const SplashWidget()
      : loginWidget(context, viewModel);

  @override
  UserViewModel viewModelBuilder(BuildContext context) => UserViewModel();

  Widget loginWidget(BuildContext context, UserViewModel viewModel) {
    final size = MediaQuery.of(context).size;

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
                    width: size.width,
                    height: size.height * 0.4,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/images/header.png'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  )
              ),
              Positioned(
                  top: size.height * 0.05,
                  child: const Image(
                    image: AssetImage('assets/images/icon.png'),
                  )
              ),
              Positioned(
                  top: size.height * 0.05,
                  left: size.width * 0.05,
                  child: IconButton(
                      style: ButtonStyle(
                          backgroundColor:
                          WidgetStateColor.resolveWith((states) => Colors.white)),
                      onPressed: () => appNavigator.back(),
                      icon: const Icon(Icons.arrow_back,
                          color: Color(0xFF6c18db), size: 30)
                  ),
              ),
              Container(
                alignment: Alignment.center,
                color: Colors.transparent,
                margin: EdgeInsets.only(top: size.height * 0.25),
                padding: EdgeInsets.symmetric(horizontal: size.width * 0.1),
                child: Center(
                  child: FormBuilder(
                    key: viewModel.formKey,
                    child: Column(
                      children: [
                        const Text(
                            "Tus datos de usuario",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 25),
                        FormBuilderTextField(
                          initialValue: viewModel.user.name,
                          textInputAction: TextInputAction.next,
                          onChanged: (value) {
                            viewModel.user.name = value ?? '';
                          },
                          keyboardType: TextInputType.text,
                          name: 'name',
                          style: const TextStyle(
                              color: Colors.black,
                              height: 1
                          ),
                          decoration: const InputDecoration(
                            labelText: 'Nombre',

                            floatingLabelBehavior: FloatingLabelBehavior.auto,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(30)),
                              borderSide: BorderSide.none,
                            ),
                            filled: true,
                            fillColor: Colors.white,
                            prefixIcon: Icon(
                              Icons.abc,
                              color: Colors.grey,
                            ),
                          ),
                          validator: FormBuilderValidators.compose([
                            FormBuilderValidators.required(
                              errorText: 'El campo no debe estar vacío',
                            ),
                          ]),
                        ),
                        const SizedBox(height: 15),
                        FormBuilderTextField(
                          initialValue: viewModel.user.email,
                          textInputAction: TextInputAction.next,
                          onChanged: (value) {
                            viewModel.user.email = value ?? '';
                          },
                          keyboardType: TextInputType.emailAddress,
                          name: 'email',
                          style: const TextStyle(
                              color: Colors.black,
                              height: 1
                          ),
                          decoration: const InputDecoration(
                            labelText: 'Email',
                            floatingLabelBehavior: FloatingLabelBehavior.auto,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(30)),
                              borderSide: BorderSide.none,
                            ),
                            filled: true,
                            fillColor: Colors.white,
                            prefixIcon: Icon(
                              Icons.abc,
                              color: Colors.grey,
                            ),
                          ),
                          validator: FormBuilderValidators.compose([
                            FormBuilderValidators.required(
                              errorText: 'El campo no debe estar vacío',
                            ),
                            FormBuilderValidators.email(
                              errorText: 'El email no es válido',
                            )
                          ]),
                        ),
                        const SizedBox(height: 15),
                        FormBuilderTextField(
                          initialValue: viewModel.user.phone,
                          textInputAction: TextInputAction.next,
                          onChanged: (value) {
                            viewModel.user.phone = value ?? '';
                          },
                          keyboardType: TextInputType.number,
                          name: 'phone',
                          style: const TextStyle(
                              color: Colors.black,
                              height: 1
                          ),
                          decoration: const InputDecoration(
                            labelText: 'Teléfono',
                            floatingLabelBehavior: FloatingLabelBehavior.auto,
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
                            FormBuilderValidators.integer(
                              errorText: 'El teléfono debe ser un número',
                            )
                          ]),
                        ),
                        const SizedBox(height: 15),
                        FormBuilderTextField(
                          name: 'password',
                          initialValue: viewModel.user.password,
                          textInputAction: TextInputAction.next,
                          onChanged: (value) {
                            if (value != null) {
                              value = value.trim();
                            }
                            if (value == null || value.isEmpty) {
                              viewModel.user.password = null;
                            }
                            viewModel.user.password = value;
                          },
                          style: const TextStyle(
                              color: Colors.black,
                              height: 1
                          ),
                          decoration: const InputDecoration(
                            labelText: 'Constraseña',
                            floatingLabelBehavior: FloatingLabelBehavior.auto,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(30)),
                              borderSide: BorderSide.none,
                            ),
                            filled: true,
                            fillColor: Colors.white,
                            prefixIcon: const Icon(
                              Icons.lock,
                              color: Colors.grey,
                            ),
                          ),
                          obscureText: true,
                          validator: FormBuilderValidators.compose([
                            FormBuilderValidators.equal(
                              checkNullOrEmpty: false,
                              viewModel.formKey.currentState?.fields['password_confirmation']?.value ?? '',
                              errorText: 'Las contraseñas no coinciden',
                            ),
                          ]),
                        ),
                        const SizedBox(height: 15),
                        FormBuilderTextField(
                          name: 'password_confirmation',
                          style: const TextStyle(
                              color: Colors.black,
                              height: 1
                          ),
                          initialValue: viewModel.user.passwordConfirmation,
                          onChanged: (value) {
                            if (value != null) {
                              value = value.trim();
                            }
                            if (value == null || value.isEmpty) {
                              viewModel.user.password = null;
                            }
                            viewModel.user.passwordConfirmation = value;
                          },
                          decoration: const InputDecoration(
                            labelText: 'Confirmación de Constraseña',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(30)),
                              borderSide: BorderSide.none,
                            ),
                            floatingLabelBehavior: FloatingLabelBehavior.auto,
                            filled: true,
                            fillColor: Colors.white,
                            prefixIcon: const Icon(
                              Icons.lock,
                              color: Colors.grey,
                            ),
                          ),
                          obscureText: true,
                          validator: FormBuilderValidators.compose([
                            FormBuilderValidators.equal(
                              checkNullOrEmpty: false,
                              viewModel.formKey.currentState?.fields['password']?.value ?? '',
                              errorText: 'Las contraseñas no coinciden',
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
                          onPressed: viewModel.updateFields ,
                          child: const Text('Actualizar'),
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
}
