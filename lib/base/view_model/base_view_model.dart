import 'dart:async';
import 'dart:ffi';
import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';
import 'package:smart_tracking/api/model/geo_fence.dart';
import 'package:smart_tracking/api/model/vehicle.dart';
import 'package:smart_tracking/base/repository/geo_fence_repository.dart';
import 'package:smart_tracking/base/repository/vehicle_repository.dart';
import 'package:get_it/get_it.dart';
import 'package:smart_tracking/utils/app_component.dart';
import 'package:smart_tracking/utils/app_base_view_model.dart';
import 'package:stacked/stacked.dart';

import 'package:smart_tracking/routes.dart';

import 'package:smart_tracking/api/api_result.dart';
import 'package:smart_tracking/utils/handle_api_error_dialog.dart';

import 'package:smart_tracking/api/api_exception.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:easy_debounce/easy_debounce.dart';

import '../../utils/extensions/dialog.extension.dart';


class BaseScreenViewModel extends AppBaseViewModel {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
  bool viewModelLoading = false;
  bool isCharging = false;
  int currentIndex = 2;
  String? vehicleId;
  Vehicle? vehicle;
  List<Vehicle> vehicles = [];
  List<GeoFence> geoFences = [];
  AppLifecycleListener? _listener;
  bool get loading => viewModelLoading;
  IconButton? notificationsButton;
  IconButton? addGeoFenceButton;
  bool addGeoFence = false;
  GeofenceMode? mode;
  double geofenceRadius = 300;
  LatLng centerCircle = const LatLng(0, 0);
  late IconButton selectedButton;
  List<LatLng> freePolygon = [];


  BaseScreenViewModel(BuildContext context) {
    appLifeCycle();
    _init(context);
    notificationsButton = IconButton(
        icon: const Badge(
            padding: EdgeInsets.all(0),
            label: Text('3'),
            child: Icon(Icons.notifications,
                color: Colors.white, size: 45)),
        onPressed: () {
          showPiDialog("Disponible pronto");
        }
    );
    addGeoFenceButton = IconButton(
      icon: const Icon(
          Icons.add,
          color: Colors.white, size: 45
      ), onPressed: () {
        appNavigator.push(Routes.addGeoFence, arguments: {
          'vehicle': vehicle,
        });
      },
    );
    selectedButton = notificationsButton!;


  }

  void appLifeCycle() {
    _listener ??= AppLifecycleListener(onResume: () {
    EasyDebounce.debounce(
         'getVehicles', const Duration(milliseconds: 300), getVehicles);
    });
  }

  void _init(BuildContext context) async {
    getVehicles();
    validateSession();
  }


  Future onDrawerItemTap(String id) async {
    var event = 'home';
    switch (id) {
      case 'home':
        appNavigator.popUntil((route) => route.isFirst);
    }
  }

  void validateSession() {
    sharedPreferencesV2.getToken().then((token) {
      if (token == null) {
        appNavigator.pushReplacement(Routes.login);
      }
    });
  }

  double getVehicleLat() {
    final value = double.tryParse(vehicle?.lat.toString() ?? "3.5978107991775845") as double;
    debugPrint("lat: $value");
    return value;
  }

  double getVehicleLon() {
    final value = double.tryParse(vehicle?.lon.toString() ?? "98.6708786302183") as double;
    debugPrint("lon: $value");
    return value;
  }

  LatLng getVehicleCoordinates() {
    final lat = getVehicleLat();
    final lon = getVehicleLon();
    final value = LatLng(lat, lon);
    debugPrint("value: ${value.toJson()}");
    return value;
  }

  Future<void> getVehicles() async {
    viewModelLoading = true;
    notifyListeners();
    locator<VehicleRepository>().getVehicles().then((response) async {
      if (response.status == Status.COMPLETED) {
        vehicles = response.data as List<Vehicle>;
        vehicle = vehicles.first;
        vehicleId = vehicle?.id.toString();

        notifyListeners();
      } else {
        throw response.apiException as ApiException;
      }
    }).catchError((error) {
      // Handle error
      debugPrint('Error: $error');
      handleApiErrorDialog(error);
    }).whenComplete((){
      viewModelLoading = false;
      notifyListeners();
    });
  }

  Future<void> getGeoFences() async {
    viewModelLoading = true;
    notifyListeners();
    locator<GeoFenceRepository>().getGeoFences().then((response) async {
      if (response.status == Status.COMPLETED) {
        geoFences = response.data as List<GeoFence>;
        notifyListeners();
      } else {
        throw response.apiException as ApiException;
      }
    }).catchError((error) {
      debugPrint('Error: $error');
      handleApiErrorDialog(error);
    }).whenComplete((){
      viewModelLoading = false;
      notifyListeners();
    });
  }

  void setGeofenceRadius(double value) {
    geofenceRadius = value;
    notifyListeners();
  }

  void changeModeGeofence(GeofenceMode newMode) {
    mode = newMode;
    notifyListeners();
  }

  void updateCenterCircle(LatLng newCenter) {
    centerCircle = newCenter;
    notifyListeners();
  }

  void addFreePoint(LatLng point) {
    freePolygon.add(point);
    notifyListeners();
  }

  void clearPolygon() {
    freePolygon.clear();
    notifyListeners();
  }

  void onVehicleTap(id) {
    vehicleId = id;
    notifyListeners();
  }

  void onDrawerTap(id) {
    switch (id) {
      case 'home':
        appNavigator.back();
        currentIndex = 2;
        notifyListeners();
        break;
      case 'profile':
        appNavigator.push(Routes.profile);
        break;
      case 'politics':
        launchUrl(
            Uri.parse('https://smarttracking.com.co/politicas-de-seguridad/'));
        break;
      case 'alerts':
        appNavigator.push(Routes.alerts);
        break;
      default:
        appNavigator.back();
        break;
    }
  }

  void onitemsTap(id) {
    switch (id) {
      case 0:
        currentIndex = id;
        break;
      case 1:
        currentIndex = id;
        getGeoFences();
        selectedButton = addGeoFenceButton!;
        notifyListeners();
        break;
      case 2:
        currentIndex = id;
        selectedButton = notificationsButton!;
        notifyListeners();
        break;
      case 3:
        launchUrl(Uri.parse(
            'https://wa.me/573001112233?text=Hola,%20necesito%20renovar%20mi%20suscripción%20de%20Smart%20Tracking'));
        break;
      case 4:
        launchUrl(Uri.parse(
            'https://wa.me/573001112233?text=Hola,%20necesito%20soporte%20con%20mi%20suscripción%20de%20Smart%20Tracking'));
        break;
    }
  }
}
