import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import 'package:smart_tracking/utils/app_component.dart';
import 'package:smart_tracking/utils/shared_preferences_v2.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:smart_tracking/routes.dart';

import 'home/view_model/home_view_model.dart';

final GetIt locator = GetIt.instance;
final RouteObserver<PageRoute> routeObserver = RouteObserver<PageRoute>();
final appNavigatorKey = StackedService.navigatorKey;
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  configureLocator();
  await sharedPreferencesV2.init();
  runApp(
      MyApp()
  );
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
