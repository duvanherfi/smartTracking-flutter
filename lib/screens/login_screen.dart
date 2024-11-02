import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

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
            ],
          ),
        ),
      ),
    );
  }
}