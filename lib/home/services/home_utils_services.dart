import 'dart:io';


import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:injectable/injectable.dart';
import 'package:smart_tracking/utils/app_base_reactive_service.dart';

//import 'package:fluttertoast/fluttertoast.dart';

import 'package:smart_tracking/routes.dart';
import 'package:smart_tracking/utils/app_component.dart';

@lazySingleton
class HomeUtilsServices extends AppBaseReactiveService {

  HomeUtilsServices() {
    listenToReactiveValues([]);
  }

  Future onDrawerItemTap(String id) async {
    var event = 'home';
    switch (id) {
      case 'home':
        appNavigator.popUntil((route) => route.isFirst);
    }
  }


  void validateSession() {
    sharedPreferencesV2.getToken().then((token) {
      if (token == null) {
        appNavigator.pushReplacement(Routes.login);
      }
    });
  }
}
