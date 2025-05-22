import 'dart:async';

import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';
import 'package:smart_tracking/api/model/geo_fence.dart';
import 'package:smart_tracking/api/model/vehicle.dart';
import 'package:smart_tracking/routes.dart';
import 'package:smart_tracking/services/home_services.dart';
import 'package:smart_tracking/utils/app_base_view_model.dart';
import 'package:smart_tracking/utils/app_component.dart';
import 'package:smart_tracking/utils/extensions/dialog.extension.dart';
import 'package:stacked/stacked.dart';
import 'package:url_launcher/url_launcher.dart';


class BaseScreenViewModel extends AppBaseViewModel {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
  final _homeServices = locator<HomeServices>();
  bool viewModelLoading = false;
  bool isCharging = false;
  int currentIndex = 2;
  AppLifecycleListener? _listener;
  IconButton? notificationsButton;
  IconButton? addGeoFenceButton;
  bool addGeoFence = false;
  GeofenceMode? mode;
  double geofenceRadius = 300;
  LatLng centerCircle = const LatLng(0, 0);
  late IconButton selectedButton;
  List<LatLng> freePolygon = [];

  bool get loading => viewModelLoading || _homeServices.loadingReactiveValue.value;
  Vehicle? get vehicle => _homeServices.vehicle.value;
  String? get vehicleId => _homeServices.vehicleId.value;
  List<Vehicle> get vehicles => _homeServices.vehicles.value;
  List<GeoFence> get geoFences => _homeServices.geoFences.value;
  GeoFence? get geoFence => _homeServices.geoFence.value;
  set vehicleId(String? id) => _homeServices.vehicleId.value = id;

  @override
  List<ListenableServiceMixin> get listenableServices => [
    _homeServices
  ];

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
        appNavigator.push(Routes.addGeoFence);
      },
    );
    selectedButton = notificationsButton!;


  }

  void appLifeCycle() {
    _listener ??= AppLifecycleListener(onStateChange: (_) {
      EasyDebounce.debounce(
           'getVehicles', const Duration(milliseconds: 300), getVehicles
      );
    });
  }

  void _init(BuildContext context) async {
    if (_homeServices.vehicles.value.isEmpty) {
      _homeServices.getVehicles();
    }
    validateSession();
  }


  Future onDrawerItemTap(String id) async {
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
    return value;
  }

  double getVehicleLon() {
    final value = double.tryParse(vehicle?.lon.toString() ?? "98.6708786302183") as double;
    return value;
  }

  LatLng getVehicleCoordinates() {
    final lat = getVehicleLat();
    final lon = getVehicleLon();
    final value = LatLng(lat, lon);
    return value;
  }

  Future<void> getVehicles() async {
    _homeServices.getVehicles();
  }

  Future<void> getGeoFences() async {
    _homeServices.getGeoFences();
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

  void onItemsTap(id) {
    switch (id) {
      case 0:
        currentIndex = id;
        break;
      case 1:
        currentIndex = id;
        selectedButton = addGeoFenceButton!;
        notifyListeners();
        getGeoFences();
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

  void setGeoFence(GeoFence geoFence) {
    _homeServices.geoFence.value = geoFence;
    notifyListeners();
  }
}
