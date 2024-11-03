import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

class RemeberPasswordScreen extends StatefulWidget {
  @override
  _RemeberPasswordScreenState createState() => _RemeberPasswordScreenState();
}

class _RemeberPasswordScreenState extends State<RemeberPasswordScreen> {

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormBuilderState>();
    final _numberKey = GlobalKey<FormBuilderFieldState>();

    return Scaffold(
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
                          onPressed: () {
                            // Validate and save the form values
                            _formKey.currentState?.saveAndValidate();
                            debugPrint(_formKey.currentState?.value.toString());

                            // On another side, can access all field values without saving form with instantValues
                            _formKey.currentState?.validate();
                            debugPrint(_formKey.currentState?.instantValue.toString());
                            Navigator.pop(context);
                            showDialog(
                              context: context,
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
                                  content: const Text(
                                    textAlign: TextAlign.justify,
                                    'Tu contraseña ha sido enviada a tu número de teléfono vía SMS y a tu correo electrónico.',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 20,
                                    ),
                                  ),
                                  actions: <Widget>[
                                    TextButton(
                                      child: Text('Aceptar'),
                                      onPressed: () {
                                        // Lógica para aceptar
                                        Navigator.of(context).pop(); // Cierra el diálogo
                                      },
                                    ),
                                  ],
                                );
                              },
                            );
                          },
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
}