import 'package:flutter/material.dart';
import 'package:smart_tracking/home/screens/home_screen.dart';
import 'package:smart_tracking/login/screens/login_screen.dart';
import 'package:smart_tracking/screens/remember_password.dart';
import 'geofences/widgets/add_geo_fence_widget.dart';

class Routes {
  static const String login = '/login';
  static const String home = '/home';
  static const String history = '/history';
  static const String rememberPassword = '/remember_password';
  static const String profile = '/profile';
  static const String alerts = '/alerts';
  static const String addGeoFence = '/add_geofence';

  static final routes = <String, WidgetBuilder>{
    login: (BuildContext context) => const LoginScreen(),
    home: (context) => const HomeScreen(),
    addGeoFence: (context) => const AddGeofenceScreen(),
    rememberPassword: (context) => RemeberPasswordScreen(),
    profile: (context) => const Placeholder(),
    alerts: (context) => const Placeholder(),
  };
}
