// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:smart_tracking/home/services/home_utils_services.dart' as _i378;
import 'package:smart_tracking/utils/app_navigator.dart' as _i405;
import 'package:smart_tracking/utils/helper_module.dart' as _i891;
import 'package:smart_tracking/utils/shared_preferences_v2.dart' as _i33;
import 'package:stacked_services/stacked_services.dart' as _i1055;

extension GetItInjectableX on _i174.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt $appInitGetIt({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    final helperModuleStacked = _$HelperModuleStacked();
    gh.lazySingleton<_i378.HomeUtilsServices>(() => _i378.HomeUtilsServices());
    gh.lazySingleton<_i405.AppNavigator>(
        () => helperModuleStacked.appNavigator);
    gh.lazySingleton<_i1055.DialogService>(
        () => helperModuleStacked.dialogService);
    gh.lazySingleton<_i1055.SnackbarService>(
        () => helperModuleStacked.snackBarService);
    gh.lazySingleton<_i33.SharedPreferencesV2>(
        () => helperModuleStacked.sharedPreferencesV2);
    gh.lazySingleton<_i1055.NavigationService>(
        () => helperModuleStacked.navigationService);
    return this;
  }
}

class _$HelperModuleStacked extends _i891.HelperModuleStacked {
  @override
  _i405.AppNavigator get appNavigator => _i405.AppNavigator();

  @override
  _i1055.DialogService get dialogService => _i1055.DialogService();

  @override
  _i1055.SnackbarService get snackBarService => _i1055.SnackbarService();

  @override
  _i33.SharedPreferencesV2 get sharedPreferencesV2 =>
      _i33.SharedPreferencesV2();

  @override
  _i1055.NavigationService get navigationService => _i1055.NavigationService();
}
