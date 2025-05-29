import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:injectable/injectable.dart';
import 'package:smart_tracking/api/api_exception.dart';
import 'package:smart_tracking/api/api_result.dart';
import 'package:smart_tracking/api/model/geo_fence.dart';
import 'package:smart_tracking/api/model/session.dart';
import 'package:smart_tracking/api/model/session_request.dart';
import 'package:smart_tracking/api/model/session_response.dart';
import 'package:smart_tracking/api/model/user.dart';
import 'package:smart_tracking/api/model/vehicle.dart';
import 'package:smart_tracking/base/repository/vehicle_repository.dart';
import 'package:smart_tracking/geofences/repository/geo_fence_repository.dart';
import 'package:smart_tracking/user/repository/session_repository.dart';
import 'package:smart_tracking/user/repository/user_repository.dart';
import 'package:smart_tracking/utils/app_base_reactive_service.dart';
import 'package:smart_tracking/utils/app_component.dart';
import 'package:smart_tracking/utils/handle_api_error_dialog.dart';
import 'package:stacked/stacked.dart';

import 'package:smart_tracking/utils/shared_preferences_v2.dart';

@lazySingleton
class HomeServices extends AppBaseReactiveService {
  final geoFence = ReactiveValue<GeoFence?>(null);
  final vehicle = ReactiveValue<Vehicle?>(null);
  final vehicleId = ReactiveValue<String?>(null);
  final geoFences = ReactiveValue<List<GeoFence>>([]);
  final vehicles = ReactiveValue<List<Vehicle>>([]);
  final user = ReactiveValue<User?>(null);
  final loadingUserInfo = ReactiveValue<bool>(false);
  final _geoFenceRepository = locator<GeoFenceRepository>();
  final _vehicleRepository = locator<VehicleRepository>();
  final _userRepository = locator<UserRepository>();
  final _sessionRepository = locator<SessionRepository>();
  final _sharedPreferencesV2 = locator<SharedPreferencesV2>();

  HomeServices() {
    listenToReactiveValues([
      geoFence,
      geoFences,
      vehicle,
      vehicleId,
      vehicles,
      user,
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

  Future<void> getUserInfo() async {
    loadingUserInfo.value = true;
    String? userId = await _sharedPreferencesV2.getUserId();
    if (userId == null || userId.isEmpty) {
      loadingUserInfo.value = false;
      return;
    }
    _userRepository.getUserInfo(userId).then((response) async {
      debugPrint("getUserInfo response: ${response.data}");
      if (response.status == Status.COMPLETED) {
        SessionResponse sessionResponse = response.data as SessionResponse;
        user.value = sessionResponse.user;
      } else {
        throw response.apiException as ApiException;
      }
    }).catchError((error) {
      loadingUserInfo.value = false;
      handleApiErrorDialog(error);
    }).whenComplete(() {
      loadingUserInfo.value = false;
    });
  }

  Future<void> updateSession() async {
    String? id = await _sharedPreferencesV2.getSessionId();
    String? token = await _sharedPreferencesV2.getToken();
    String? pushToken = await _sharedPreferencesV2.getPushTokenFirebase();
    if (id == null || token == null || pushToken == null) {
      return;
    }
    Session session = Session(
        id: id, token: token, pushToken: pushToken
    );
    _sessionRepository.updateSession(session);
  }
}