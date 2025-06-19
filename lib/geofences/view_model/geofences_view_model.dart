import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_dragmarker/flutter_map_dragmarker.dart';
import 'package:latlong2/latlong.dart';
import 'package:smart_tracking/api/api_exception.dart';
import 'package:smart_tracking/api/api_result.dart';
import 'package:smart_tracking/api/model/area_geojson.dart';
import 'package:smart_tracking/api/model/centroid_geojson.dart';
import 'package:smart_tracking/api/model/geo_fence.dart';
import 'package:smart_tracking/api/model/vehicle.dart';
import 'package:smart_tracking/base/repository/vehicle_repository.dart';
import 'package:smart_tracking/geofences/repository/geo_fence_repository.dart';
import 'package:smart_tracking/routes.dart';
import 'package:smart_tracking/services/home_services.dart';
import 'package:smart_tracking/utils/app_base_view_model.dart';
import 'package:smart_tracking/utils/app_component.dart';
import 'package:smart_tracking/utils/extensions/dialog.extension.dart';
import 'package:smart_tracking/utils/handle_api_error_dialog.dart';
import 'package:stacked/stacked.dart';


class GeoFencesViewModel extends AppBaseViewModel {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
  final GlobalKey mapKey = GlobalKey();
  final GlobalKey<FormBuilderState> formKey = GlobalKey<FormBuilderState>();
  final numberKey = GlobalKey<FormBuilderFieldState>();
  final _homeServices = locator<HomeServices>();
  bool viewModelLoading = false;
  bool isCharging = false;
  bool showForm = false;
  int currentIndex = 0;
  AreaGeoJson? recommended;

  GeofenceMode mode = GeofenceMode.circle;
  List<Vehicle> selectedVehicles = [];
  double geofenceRadius = 1000;
  LatLng? centerCircle;
  List<LatLng> freePolygon = [];
  MapController mapController = MapController();

  bool get loading => viewModelLoading || _homeServices.loadingReactiveValue.value;
  Vehicle? get vehicle => _homeServices.vehicle.value;
  List<Vehicle> get vehicles => _homeServices.vehicles.value;
  GeoFence? get geoFence => _homeServices.geoFence.value;

  @override
  List<ListenableServiceMixin> get listenableServices => [
    _homeServices
  ];


  GeoFencesViewModel(BuildContext context){
    _init();
  }

  void _init() {
    if(geoFence != null){
      debugPrint("geoFence: ${geoFence?.toJson()}");
      mode = GeofenceMode.values[geoFence!.typeCD ?? 1];
      geofenceRadius = (geoFence!.radius ?? 1) * 1000;
      if (mode == GeofenceMode.circle) {
        centerCircle = LatLng(geoFence!.centroidGeojson!.coordinates[1], geoFence!.centroidGeojson!.coordinates[0]);
      } else if (mode == GeofenceMode.free || mode == GeofenceMode.recommended) {
        freePolygon = geoFence!.areaGeojson!.coordinates[0].map((e) => LatLng(e[1], e[0])).toList();
      }
      selectedVehicles = vehicles.where((v) => geoFence?.vehicleIds?.contains(v.id) ?? false).toList();
      notifyListeners();
    }
  }

  void setShowForm(bool value) {
    showForm = value;
    notifyListeners();
  }

  dynamic setSelectedVehicles(List<dynamic> vehicles) {
    debugPrint("vehicles: ${vehicles.length} | $vehicles");
    selectedVehicles = vehicles as List<Vehicle>;
    debugPrint("selectedVehicles: ${selectedVehicles.length} | $selectedVehicles");
    notifyListeners();
  }


  void validateSession() {
    sharedPreferencesV2.getToken().then((token) {
      if (token == null) {
        appNavigator.pushReplacement(Routes.login);
      }
    });
  }

  Widget? navigationBar(){
    if(showForm){
      return null;
    }else{
      return BottomNavigationBar(
        iconSize: 60,
        type: BottomNavigationBarType.fixed,
        currentIndex: currentIndex,
        enableFeedback: true,
        backgroundColor: Colors.white,
        selectedItemColor: Color(0xFF18BEDB),
        unselectedItemColor: Color(0xFF6c18db),
        onTap: changeModeGeofence,
        items: [
          const BottomNavigationBarItem(
            icon: Icon(Icons.add_circle),
            tooltip: 'Circulo',
            label: 'Circulo',
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.edit),
            label: 'Dibujo libre',
            tooltip: 'Dibujo libre',
          ),
          BottomNavigationBarItem(
            backgroundColor: Colors.white,
            icon: Image.asset(
              'assets/images/ia.png',
              height: 60,
            ),
            label: 'Recomendado',
            tooltip: 'Recomendado',
          ),
          const BottomNavigationBarItem(
              icon: Icon(Icons.delete), label: 'Eliminar',
              tooltip: 'Eliminar'
          ),
        ],
      );
    }
  }

  Widget getMarkers() {
    return DragMarkers(
      alignment: Alignment.topCenter,
      markers: freePolygon.asMap().entries.map((entry) {
        final index = entry.key;
        final point = entry.value;

        return DragMarker(
            point: point,
            builder: (_, __, ___) => const Icon(Icons.location_on, size: 50, color: Colors.red,),
            onDragUpdate: (details, latLng) {
              freePolygon[index] = latLng;
              notifyListeners();
            },
            size: const Size.square(50)
        );
      }).toList(),
    );
  }

  bool canContinue() {
    if (mode == GeofenceMode.circle && centerCircle != null) {
      return true;
    } else if (mode == GeofenceMode.free && freePolygon.isNotEmpty && freePolygon.length > 2) {
      return true;
    } else if (mode == GeofenceMode.recommended && freePolygon.isNotEmpty && freePolygon.length > 2) {
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
    } else if ([GeofenceMode.free, GeofenceMode.recommended].contains(mode) && freePolygon.isNotEmpty) {
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

  void setGeofenceRadius(double value) {
    geofenceRadius = value;
    notifyListeners();
  }

  void changeModeGeofence(int position) {
    switch(position){
      case 0:
        mode = GeofenceMode.circle;
        currentIndex = 0;
        break;
      case 1:
        mode = GeofenceMode.free;
        currentIndex = 1;
        break;
      case 2:
        mode = GeofenceMode.recommended;
        currentIndex = 2;
        getRecommended();
        break;
      case 3:
        clearPolygon();
        break;
      default:
        mode = GeofenceMode.circle;
    }
    _init();
    debugPrint("position: $position");
    debugPrint("mode: $mode");
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
    debugPrint("currentIndex: $currentIndex");
  }

  void back(){
    if (showForm){
      showForm = false;
      notifyListeners();
    } else {
      appNavigator.back();
    }
  }

  Future<void> getRecommended() async {
    viewModelLoading = true;
    notifyListeners();
    locator<VehicleRepository>().getRecommended(vehicle!.id as String).then((response) async {
      if (response.status == Status.COMPLETED) {
        recommended = response.data as AreaGeoJson;
        freePolygon = recommended!.coordinates[0].map((e) => LatLng(e[1], e[0])).toList();
        viewModelLoading = false;
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

  AreaGeoJson? getAreaGeojson(){
    List<GeofenceMode> modes = [
      GeofenceMode.recommended,
      GeofenceMode.free
    ];
    if (modes.contains(mode)) {
      LatLng first_point = freePolygon.first;
      return AreaGeoJson(
          type: "Polygon",
          coordinates: [
            freePolygon.map(
            (e) => [e.longitude, e.latitude]
            ).toList() +
            [
              [first_point.longitude, first_point.latitude]
            ]
          ]
      );
    }

    return null;
  }

  CentroidGeojson? getCentroidGeojson(){
    if (mode == GeofenceMode.circle && centerCircle != null) {
      return CentroidGeojson(
        type: "Point",
        coordinates: [
          centerCircle!.longitude,
          centerCircle!.latitude
        ]
      );
    }
    return null;
  }

  String? getName(){
    return geoFence?.name;
  }

  String? getDescription(){
   return geoFence?.description;
  }

  Map<String, GeoFence> getBody(){
    GeoFence requestGeoFence = GeoFence(
        id: geoFence?.id ?? "created",
        vehicleIds: selectedVehicles.map((v) => v.id).toList(),
        name: formKey.currentState?.fields["name"]?.value,
        description: formKey.currentState?.fields["description"]?.value,
        areaGeojson: getAreaGeojson(),
        centroidGeojson: getCentroidGeojson(),
        radius: geofenceRadius/1000,
        typeCD: mode.index
    );
    return {
      "geo_fence": requestGeoFence
    };
  }

  void chooseModeApi(){
    if (geoFence != null) {
      updateGeofences();
    } else {
      createGeofences();
    }
  }

  Future<void> createGeofences() async {
    viewModelLoading = true;
    notifyListeners();

    locator<GeoFenceRepository>().createGeoFence(getBody()).then((response) async {
      if (response.status == Status.COMPLETED) {
        appNavigator.back();
        showPiDialog(
          "Geocerca creada exitosamente!",
        );
        viewModelLoading = false;
        notifyListeners();
        _homeServices.getGeoFences();
      } else {
        throw response.apiException as ApiException;
      }
    }).catchError((error) {
      viewModelLoading = false;
      notifyListeners();
      handleApiErrorDialog(error);
    }).whenComplete((){
      viewModelLoading = false;
      notifyListeners();
    });
  }

  Future<void> updateGeofences() async {
    viewModelLoading = true;
    notifyListeners();

    locator<GeoFenceRepository>().updateGeoFence(geoFence!.id, getBody()).then((response) async {
      if (response.status == Status.COMPLETED) {
        appNavigator.back();
        showPiDialog(
          "Geocerca actualizada exitosamente!",
        );
        viewModelLoading = false;
        notifyListeners();
        _homeServices.getGeoFences();
      } else {
        throw response.apiException as ApiException;
      }
    }).catchError((error) {
      viewModelLoading = false;
      notifyListeners();
      handleApiErrorDialog(error);
    }).whenComplete((){
      viewModelLoading = false;
      notifyListeners();
    });
  }
}
