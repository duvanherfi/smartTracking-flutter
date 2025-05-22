import 'dart:async';

import 'package:injectable/injectable.dart';
import 'package:smart_tracking/api/api_exception.dart';
import 'package:smart_tracking/api/api_result.dart';
import 'package:smart_tracking/api/model/geo_fence.dart';
import 'package:smart_tracking/api/model/vehicle.dart';
import 'package:smart_tracking/base/repository/vehicle_repository.dart';
import 'package:smart_tracking/geofences/repository/geo_fence_repository.dart';
import 'package:smart_tracking/utils/app_base_reactive_service.dart';
import 'package:smart_tracking/utils/app_component.dart';
import 'package:smart_tracking/utils/handle_api_error_dialog.dart';
import 'package:stacked/stacked.dart';

@lazySingleton
class HomeServices extends AppBaseReactiveService {
  final geoFence = ReactiveValue<GeoFence?>(null);
  final vehicle = ReactiveValue<Vehicle?>(null);
  final vehicleId = ReactiveValue<String?>(null);
  final geoFences = ReactiveValue<List<GeoFence>>([]);
  final vehicles = ReactiveValue<List<Vehicle>>([]);
  final _geoFenceRepository = locator<GeoFenceRepository>();
  final _vehicleRepository = locator<VehicleRepository>();

  HomeServices() {
    listenToReactiveValues([
      geoFence,
      geoFences,
      vehicle,
      vehicleId,
      vehicles,
      loadingReactiveValue
    ]);
  }

  void resetValues() {
    geoFence.value = null;
    geoFences.value = [];
    vehicle.value = null;
    vehicles.value = [];
    vehicleId.value = null;
    loadingReactiveValue.value = false;
  }

  Future<void> getGeoFences() async {
    loadingReactiveValue.value = true;
    _geoFenceRepository.getGeoFences().then((response) async {
      if (response.status == Status.COMPLETED) {
        geoFences.value = response.data as List<GeoFence>;
      } else {
        throw response.apiException as ApiException;
      }
    }).catchError((error) {
      loadingReactiveValue.value = false;
      handleApiErrorDialog(error);
    }).whenComplete((){
      loadingReactiveValue.value = false;
    });
  }

  Future<void> getVehicles() async {
    loadingReactiveValue.value = true;
    _vehicleRepository.getVehicles().then((response) async {
      if (response.status == Status.COMPLETED) {
        vehicles.value = response.data as List<Vehicle>;
        vehicle.value = vehicles.value.first;
        vehicleId.value = vehicle.value?.id.toString();
      } else {
        throw response.apiException as ApiException;
      }
    }).catchError((error) {
      loadingReactiveValue.value = false;
      handleApiErrorDialog(error);
    }).whenComplete(() {
      loadingReactiveValue.value = false;
    });
  }
}