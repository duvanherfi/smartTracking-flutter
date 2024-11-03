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

    return Scaffold(
      appBar: AppBar(
        title: const Text('Recuperar contraseña'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('Cancelar', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
      resizeToAvoidBottomInset: false,
      body: Placeholder(),
    );
  }
}