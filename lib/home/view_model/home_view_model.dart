import 'dart:async';
import 'package:flutter/material.dart';
import 'package:smart_tracking/utils/app_component.dart';
import 'package:smart_tracking/utils/app_base_view_model.dart';
import 'package:stacked/stacked.dart';

import 'package:smart_tracking/routes.dart';


class HomeViewModel extends AppBaseViewModel {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
  bool viewModelLoading = false;
  bool isCharging = false;
  bool _checkinLoading = false;
  AppLifecycleListener? _listener;

  bool get loading => viewModelLoading || _checkinLoading;


  HomeViewModel(BuildContext context) {
    appLifeCycle();
    _init(context);
  }

  void appLifeCycle() {
    _listener ??= AppLifecycleListener(onResume: () {
    // EasyDebounce.debounce(
    //     'resumeCheckin', const Duration(milliseconds: 300), updateCheckin);
    });
  }

  void _init(BuildContext context) async {
    validateSession();
  }


  Future onDrawerItemTap(String id) async {
    var event = 'home';
    switch (id) {
      case 'home':
        appNavigator.popUntil((route) => route.isFirst);
    }
  }

  @override
  void dispose() {
    _listener?.dispose();
    _listener = null;
    super.dispose();
  }


  void validateSession() {
    sharedPreferencesV2.getToken().then((token) {
      if (token == null) {
        appNavigator.pushReplacement(Routes.login);
      }
    });
  }
}
