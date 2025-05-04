import 'dart:async';
import 'dart:ffi';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
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


class GeoFencesViewModel extends AppBaseViewModel {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
  bool viewModelLoading = false;
  bool isCharging = false;

  GeofenceMode? mode;
  Vehicle? vehicle;
  double geofenceRadius = 1000;
  LatLng? centerCircle;
  List<LatLng> freePolygon = [];


  GeoFencesViewModel(BuildContext context);


  void validateSession() {
    sharedPreferencesV2.getToken().then((token) {
      if (token == null) {
        appNavigator.pushReplacement(Routes.login);
      }
    });
  }

  Widget getMarkers(){
    return MarkerLayer(
        markers:  freePolygon.asMap().entries.map((entry) {
          final index = entry.key;
          final point = entry.value;

          return Marker(
            point: point,
            alignment: Alignment.topCenter,
            child: Draggable<LatLng>(
                data: point,
                feedback: const Icon(Icons.location_on, color: Colors.red, size: 40),
                childWhenDragging: const Icon(Icons.location_on, color: Colors.grey, size: 40),
                child: GestureDetector(
                  onTap: () {
                    debugPrint("Marcador seleccionado: $point");
                  },
                  child: const Icon(Icons.location_on, color: Colors.red, size: 40),
                ),
                onDragEnd: (details) {
                  /*final newPoint = LatLng(
                    details.offset.dx,
                    details.offset.dy,
                  );*/
                  debugPrint("Marcador arrastrado a: ${details.offset.toString()}");
                  //details.offset

                  // Actualiza el punto en freePolygon
                  //freePolygon[index] = newPoint;
                  //notifyListeners();
                },
            )
          );
        }).toList()
    );
  }

  bool canContinue() {
    if (mode == GeofenceMode.circle && centerCircle != null) {
      return true;
    } else if (mode == GeofenceMode.free && freePolygon.isNotEmpty && freePolygon.length > 2) {
      return true;
    }
    return false;
  }

  Widget getMarkerShape() {
    if (mode == GeofenceMode.circle && centerCircle != null) {
      return CircleLayer(
        circles: [
          CircleMarker(
            point: centerCircle!,
            color: Colors.red.withValues(alpha: 0.3),
            borderStrokeWidth: 2,
            borderColor: Colors.red,
            useRadiusInMeter: true,
            radius: geofenceRadius,
          )
        ],
      );
    } else if (mode == GeofenceMode.free && freePolygon.isNotEmpty) {
      return PolygonLayer(
        polygons: [
          Polygon(
            points: freePolygon,
            color: Colors.blue.withValues(alpha: 0.3),
            borderColor: const Color(0xFF060EBB),
            borderStrokeWidth: 2,
          ),
        ],
      );
    }
    return const SizedBox();
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
    centerCircle = null;
    notifyListeners();
  }
}
