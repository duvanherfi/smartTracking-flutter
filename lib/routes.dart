import 'package:flutter/material.dart';
import 'package:smart_tracking/home/screens/home_screen.dart';
import 'package:smart_tracking/login/screens/login_screen.dart';
import 'package:smart_tracking/remember_password/screen/remember_password.dart';
import 'package:smart_tracking/share/screens/share_screen.dart';
import 'package:smart_tracking/user/screens/user_screen.dart';

import 'geofences/screen/add_geo_fence_widget.dart';

class Routes {
  static const String login = '/login';
  static const String home = '/home';
  static const String user = '/user';
  static const String history = '/history';
  static const String rememberPassword = '/remember_password';
  static const String alerts = '/alerts';
  static const String addGeoFence = '/add_geofence';
  static const String share = '/share';

  static final routes = <String, WidgetBuilder>{
    login: (BuildContext context) => const LoginScreen(),
    home: (context) => const HomeScreen(),
    user: (context) => const UserScreen(),
    addGeoFence: (context) => const AddGeofenceScreen(),
    rememberPassword: (context) => RemeberPasswordScreen(),
    share: (context) => const ShareScreen(),
    alerts: (context) => const Placeholder(),
  };
}
