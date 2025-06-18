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
import 'package:smart_tracking/api/model/user_notification.dart';
import 'package:smart_tracking/api/model/vehicle.dart';
import 'package:smart_tracking/base/repository/vehicle_repository.dart';
import 'package:smart_tracking/geofences/repository/geo_fence_repository.dart';
import 'package:smart_tracking/routes.dart';
import 'package:smart_tracking/services/home_services.dart';
import 'package:smart_tracking/user_notifications/repository/user_notification_repository.dart';
import 'package:smart_tracking/utils/app_base_view_model.dart';
import 'package:smart_tracking/utils/app_component.dart';
import 'package:smart_tracking/utils/extensions/dialog.extension.dart';
import 'package:smart_tracking/utils/handle_api_error_dialog.dart';
import 'package:stacked/stacked.dart';
import 'package:url_launcher/url_launcher.dart';


class UserNotificationViewModel extends AppBaseViewModel {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
  final GlobalKey mapKey = GlobalKey();
  final _homeServices = locator<HomeServices>();
  final _userNotificationRepository = locator<UserNotificationRepository>();
  bool viewModelLoading = false;
  List<UserNotification> userNotifications = [];
  UserNotification? userNotification;
  MapController mapController = MapController();

  bool get loading => viewModelLoading || _homeServices.loadingReactiveValue.value;
  Vehicle? get vehicle => _homeServices.vehicle.value;
  String? get vehicleId => _homeServices.vehicleId.value;
  List<Vehicle> get vehicles => _homeServices.vehicles.value;

  @override
  List<ListenableServiceMixin> get listenableServices => [
    _homeServices
  ];


  UserNotificationViewModel(BuildContext context){
    getUserNotifications();
  }

  Future<void> getUserNotifications() async {
    viewModelLoading = true;
    notifyListeners();
    _userNotificationRepository.getUserNotifications().then((response) async {
      if (response.status == Status.COMPLETED) {
        userNotifications = response.data as List<UserNotification>;
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

  void onVehicleTap(vehicle) {
    _homeServices.vehicle.value = vehicles.firstWhere(
      (v) => v.id == vehicle.id
    );
    notifyListeners();
  }

  Future<dynamic> userNotificationAction(BuildContext context, UserNotification userNotification) {
    final point = LatLng(userNotification.lat ?? 0, userNotification.lon ?? 0);
    final size = MediaQuery.of(context).size;
    return showDialog(
      barrierDismissible: false,
      context: context,
      builder: (_) => AlertDialog(
        actions: [
          MaterialButton(
              onPressed: ()=> appNavigator.back(),
            child: Text(
                "Cerrar",
                style: TextStyle(
                    color: Theme.of(context).primaryColor,
                  fontSize: 20
                )
            )
          )
        ],
        content: SizedBox(
          width: size.width * 0.95,
          height: size.height * 0.9,
          child: FlutterMap(
            options: MapOptions(
              initialCenter: point,
              initialZoom: 15,
            ),
            children: [
              TileLayer(
                // Bring your own tiles
                urlTemplate:
                'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                // For demonstration only
                userAgentPackageName: 'com.smart.tracking.smart_tracking', // Add your app identifier
                // And many more recommended properties!
              ),
              RichAttributionWidget(
                // Include a stylish prebuilt attribution widget that meets all requirments
                attributions: [
                  TextSourceAttribution(
                    'OpenStreetMap contributors',
                    onTap: () => launchUrl(Uri.parse(
                        'https://openstreetmap.org/copyright')), // (external)
                  ),
                  // Also add images...
                ],
              ),
              MarkerLayer(
                  markers: [
                    Marker(
                        point: point,
                        child: const Icon(
                            Icons.location_on,
                            size: 50,
                            color: Colors.red
                        )
                    )
                  ]
              )
            ],
          ),
        ),
      ),
    );
  }
}
