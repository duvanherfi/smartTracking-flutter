import 'package:flutter/material.dart';
import 'package:smart_tracking/screens/history_screen.dart';
import 'package:smart_tracking/home/screens/home_screen.dart';
import 'package:smart_tracking/screens/login_screen.dart';
import 'package:smart_tracking/screens/remember_password.dart';

class Routes {
  static const String login = '/login';
  static const String home = '/home';
  static const String history = '/history';
  static const String rememberPassword = '/remember_password';

  static final routes = <String, WidgetBuilder>{
    login: (BuildContext context) => LoginScreen(),
    home: (context) => HomeScreen(),
    history: (context) => HistoryScreen(),
    rememberPassword: (context) => RemeberPasswordScreen(),
  };
}
