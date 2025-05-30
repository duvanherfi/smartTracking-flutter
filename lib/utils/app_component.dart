import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:smart_tracking/api/base_chopper_module.dart';
import 'package:smart_tracking/api/datasources/datasources.dart';
import 'package:smart_tracking/api/request_json_error_converter.dart';
import 'package:smart_tracking/utils/app_component.config.dart';
import 'package:smart_tracking/utils/config.dart';
import 'package:smart_tracking/utils/enviroments.dart';
import 'package:smart_tracking/utils/shared_preferences_v2.dart';
import 'package:stacked_services/stacked_services.dart';

import 'app_navigator.dart';

final GetIt locator = GetIt.instance;

@InjectableInit(preferRelativeImports: false, initializerName: r'$appInitGetIt')
void configureLocator() => locator.$appInitGetIt();

final sharedPreferencesV2 = locator<SharedPreferencesV2>();
final galleryDialogService = locator<DialogService>();
final appNavigator = locator<AppNavigator>();
final config = locator<Config>();
final snackBarService = locator<SnackbarService>();
enum GeofenceMode { circle, free, recommended }


void configureLocatorApp() {
  initDatasources();
  initConverters();
}

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

void initDatasources() {
  dataSources.addAll(chopperDataSources);
}

void initConverters() {
  errorConverter = RequestJsonErrorConverter();
}

Future<void> setUpRemoteConfig() async {
  try {
    locator.registerLazySingleton<Config>(Config.new);
    config.initLocal();

    Environments.initEnvironmentUrls({});

  } catch (_) {
    Environments.initEnvironmentUrls({});
  }
}

Future<void> generatePushToken() async {
  final firebaseMessaging = FirebaseMessaging.instance;
  String? token;
  if (Platform.isIOS) {
    token = await firebaseMessaging.getAPNSToken() ?? '';
  } else if (Platform.isAndroid) {
    token = await firebaseMessaging.getToken();
  }


  sharedPreferencesV2.setPushTokenFirebase(token);
}
