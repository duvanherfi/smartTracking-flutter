import 'dart:async';

import 'package:flutter/material.dart';
import 'package:smart_tracking/routes.dart';
import 'package:smart_tracking/services/home_services.dart';
import 'package:smart_tracking/utils/app_base_view_model.dart';
import 'package:smart_tracking/utils/app_component.dart';
import 'package:stacked/stacked.dart';


class HomeViewModel extends AppBaseViewModel {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
  final _homeServices = locator<HomeServices>();
  bool viewModelLoading = false;
  bool isCharging = false;
  AppLifecycleListener? _listener;

  bool get loading => viewModelLoading || _homeServices.loadingUserInfo.value;

  @override
  List<ListenableServiceMixin> get listenableServices => [
    _homeServices
  ];

  HomeViewModel(BuildContext context) {
    _init(context);
    generatePushToken();
    _homeServices.getUserInfo();
    _homeServices.updateSession();
  }

  void _init(BuildContext context) async {
    validateSession();
  }


  Future onDrawerItemTap(String id) async {
    var event = 'home';
    switch (id) {
      case 'home':
        appNavigator.popUntil((route) => route.isFirst);
        break;
      case 'user':
        appNavigator.push(Routes.user);
        break;
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
