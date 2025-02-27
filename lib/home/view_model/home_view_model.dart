import 'dart:async';
import 'package:flutter/material.dart';
import 'package:smart_tracking/utils/app_component.dart';
import 'package:smart_tracking/utils/app_base_view_model.dart';
import 'package:smart_tracking/home/services/home_utils_services.dart';
import 'package:stacked/stacked.dart';


class HomeViewModel extends AppBaseViewModel {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
  final _homeUtilsServices = locator<HomeUtilsServices>();
  bool viewModelLoading = false;
  bool isCharging = false;
  bool _checkinLoading = false;
  AppLifecycleListener? _listener;

  @override
  List<ReactiveServiceMixin> get reactiveServices => [
        _homeUtilsServices,
      ];

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
    //_homeUtilsServices.validateSession();
  }


  Future onDrawerItemTap(String id) async {
    _homeUtilsServices.onDrawerItemTap(
      id
    );
  }

  @override
  void dispose() {
    _listener?.dispose();
    _listener = null;
    super.dispose();
  }
}
