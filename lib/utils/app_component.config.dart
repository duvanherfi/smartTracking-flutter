// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:chopper/chopper.dart' as _i31;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:smart_tracking/api/chopper_modules.dart' as _i821;
import 'package:smart_tracking/api/datasources/geo_fence_datasource.dart'
    as _i1063;
import 'package:smart_tracking/api/datasources/login_datasource.dart' as _i805;
import 'package:smart_tracking/api/datasources/vehicle_datasource.dart'
    as _i810;
import 'package:smart_tracking/api/provider_api_module.dart' as _i901;
import 'package:smart_tracking/base/repository/vehicle_repository.dart'
    as _i1051;
import 'package:smart_tracking/geofences/repository/geo_fence_repository.dart'
    as _i416;
import 'package:smart_tracking/login/repository/login_repository.dart' as _i956;
import 'package:smart_tracking/services/home_services.dart' as _i388;
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
    final chopperModule = _$ChopperModule();
    final providerApiModule = _$ProviderApiModule();
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
    gh.lazySingleton<_i31.ChopperClient>(() => chopperModule.chopperBuilder());
    gh.lazySingleton<_i388.HomeServices>(() => _i388.HomeServices());
    gh.factory<_i805.LoginDataSource>(() =>
        providerApiModule.provideLoginDataSource(gh<_i31.ChopperClient>()));
    gh.factory<_i810.VehicleDataSource>(() =>
        providerApiModule.provideVehicleDataSource(gh<_i31.ChopperClient>()));
    gh.factory<_i1063.GeoFenceDataSource>(() =>
        providerApiModule.provideGeoFenceDataSource(gh<_i31.ChopperClient>()));
    gh.factory<_i956.LoginRepository>(
        () => _i956.LoginRepository.from(gh<_i805.LoginDataSource>()));
    gh.factory<_i1051.VehicleRepository>(
        () => _i1051.VehicleRepository.from(gh<_i810.VehicleDataSource>()));
    gh.factory<_i416.GeoFenceRepository>(
        () => _i416.GeoFenceRepository.from(gh<_i1063.GeoFenceDataSource>()));
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

class _$ChopperModule extends _i821.ChopperModule {}

class _$ProviderApiModule extends _i901.ProviderApiModule {}
