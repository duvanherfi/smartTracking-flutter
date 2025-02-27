import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:smart_tracking/utils/app_component.config.dart';
import 'package:smart_tracking/utils/shared_preferences_v2.dart';
import 'package:stacked_services/stacked_services.dart';
import 'app_navigator.dart';

final GetIt locator = GetIt.instance;

@InjectableInit(preferRelativeImports: false, initializerName: r'$appInitGetIt')
void configureLocator() => locator.$appInitGetIt();

final sharedPreferencesV2 = locator<SharedPreferencesV2>();
final appNavigator = locator<AppNavigator>();
final snackBarService = locator<SnackbarService>();

Future init() async {
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitDown,
    DeviceOrientation.portraitUp,
  ]);
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    ),
  );
}
