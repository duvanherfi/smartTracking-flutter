import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:smart_tracking/routes.dart';
import 'package:smart_tracking/utils/app_component.dart';
import 'package:smart_tracking/utils/shared_preferences_v2.dart';
import 'package:smart_tracking/utils/style/dialog.style.dart';
import 'package:stacked_services/stacked_services.dart';

import 'firebase_options.dart';

final GetIt locator = GetIt.instance;
final RouteObserver<PageRoute> routeObserver = RouteObserver<PageRoute>();
final appNavigatorKey = StackedService.navigatorKey;
Future<void> main() async {
  initializeDateFormatting();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await FirebaseMessaging.instance.requestPermission(provisional: true);
  await dotenv.load();
  configureLocator();
  await initLocators();
  await sharedPreferencesV2.init();
  runApp(
      const MyApp()
  );
}

Future<void> initLocators() async {
  setupDialogUi();
  configureLocatorApp();
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
  // This widget is the root of your application.
  final _sharedPreferences = locator<SharedPreferencesV2>();
  String? _sesionToken;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addObserver(this);

    locator<SharedPreferencesV2>().init().then((_) {
      _sharedPreferences.setAppIsHidden(false);
    });
    updateSesionToken();
  }

  Future<void> updateSesionToken() async {
    final token = await _sharedPreferences.getToken();
    setState(() {
      _sesionToken = token;
      if (_sesionToken != null) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          appNavigator.clearStackAndShow(Routes.home);
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Login App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0x006c18db)),
        useMaterial3: true,
      ),
      initialRoute: Routes.home,
      navigatorKey: appNavigatorKey,
      navigatorObservers: [
        routeObserver,
        StackedService.routeObserver
      ],
      routes: Routes.routes,
    );
  }
}
