import 'package:injectable/injectable.dart';
import 'package:smart_tracking/utils/shared_preferences_v2.dart';
import 'package:stacked_services/stacked_services.dart';

import 'app_navigator.dart';

@module
abstract class HelperModuleStacked {
  @lazySingleton
  AppNavigator get appNavigator;

  @lazySingleton
  DialogService get dialogService;

  @lazySingleton
  SnackbarService get snackBarService;

  @lazySingleton
  SharedPreferencesV2 get sharedPreferencesV2;

  @lazySingleton
  NavigationService get navigationService;
}
