import 'dart:async';

import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:intl/intl.dart';
import 'package:latlong2/latlong.dart';
import 'package:smart_tracking/api/api_exception.dart';
import 'package:smart_tracking/api/api_result.dart';
import 'package:smart_tracking/api/model/geo_fence.dart';
import 'package:smart_tracking/api/model/trip.dart';
import 'package:smart_tracking/api/model/vehicle.dart';
import 'package:smart_tracking/geofences/repository/geo_fence_repository.dart';
import 'package:smart_tracking/home/repository/report_repository.dart';
import 'package:smart_tracking/home/widgets/geofence_widget.dart';
import 'package:smart_tracking/home/widgets/history_widget.dart';
import 'package:smart_tracking/home/widgets/home_widget.dart';
import 'package:smart_tracking/home/widgets/vehicle_map_widget.dart';
import 'package:smart_tracking/routes.dart';
import 'package:smart_tracking/services/home_services.dart';
import 'package:smart_tracking/utils/app_base_view_model.dart';
import 'package:smart_tracking/utils/app_component.dart';
import 'package:smart_tracking/utils/enviroments.dart';
import 'package:smart_tracking/utils/extensions/dialog.extension.dart';
import 'package:smart_tracking/utils/handle_api_error_dialog.dart';
import 'package:stacked/stacked.dart';
import 'package:url_launcher/url_launcher.dart';


class BaseScreenViewModel extends AppBaseViewModel {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
  final GlobalKey mapKey = GlobalKey();
  final _homeServices = locator<HomeServices>();
  final _geoFenceRepository = locator<GeoFenceRepository>();
  final _reportRepository = locator<ReportRepository>();
  static const List<Widget> widgetOptions = <Widget>[
    HistoryWidget(),
    GeofenceWidget(),
    HomeWidget(),
    VehicleMapWidget(),
  ];
  final DateFormat format = DateFormat('yyyy-MM-ddTHH:mm:ssZ');
  DateTime? fromDate;
  DateTime? toDate;
  List<DateTime> radioDates = [];
  bool viewModelLoading = false;
  bool isCharging = false;
  int currentIndex = 2;
  AppLifecycleListener? _listener;
  IconButton? notificationsButton;
  IconButton? addGeoFenceButton;
  IconButton? filterButton;
  bool addGeoFence = false;
  GeofenceMode? mode;
  double geofenceRadius = 300;
  LatLng centerCircle = const LatLng(0, 0);
  late IconButton selectedButton;
  List<LatLng> freePolygon = [];
  List<Trip> trips = [];
  late Widget childBase = widgetOptions[2];

  bool get loading => viewModelLoading || _homeServices.loadingReactiveValue.value;
  Vehicle? get vehicle => _homeServices.vehicle.value;
  String? get vehicleId => _homeServices.vehicleId.value;
  List<Vehicle> get vehicles => _homeServices.vehicles.value;
  List<GeoFence> get geoFences => _homeServices.geoFences.value;
  GeoFence? get geoFence => _homeServices.geoFence.value;
  bool get vehicleMap => childBase.runtimeType == VehicleMapWidget;
  set vehicleId(String? id) => _homeServices.vehicleId.value = id;

  @override
  List<ListenableServiceMixin> get listenableServices => [
    _homeServices
  ];

  BaseScreenViewModel(BuildContext context) {
    appLifeCycle();
    _init(context);
    notificationsButton = IconButton(
        icon: const Icon(
            Icons.notifications,
            color: Colors.white, size: 45
        ),
        onPressed: () {
          appNavigator.push(Routes.userNotificationScreen);
        }
    );
    addGeoFenceButton = IconButton(
      icon: const Icon(
          Icons.add,
          color: Colors.white, size: 45
      ), onPressed: () {
        _homeServices.geoFence.value = null;
        notifyListeners();
        appNavigator.push(Routes.addGeoFence);
      },
    );
    filterButton = IconButton(
      icon: const Icon(
          Icons.filter_alt_outlined,
          color: Colors.white, size: 45
      ), onPressed: openFilter,
    );
    selectedButton = notificationsButton!;
    childBase = widgetOptions[2];

  }

  void appLifeCycle() {
    _listener ??= AppLifecycleListener(onShow: () {
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

  void onVehicleTap(vehicle) {
    vehicleId = vehicle.id;
    _homeServices.vehicle.value = vehicle;
    notifyListeners();
  }

  void onDrawerTap(id) {
    switch (id) {
      case 'home':
        appNavigator.back();
        currentIndex = 2;
        notifyListeners();
        break;
      case 'user':
        appNavigator.push(Routes.user);
        break;
      case 'politics':
        launchUrl(Uri.tryParse(Environments.baseUrl.replaceAll("api/v1/", "")+"legal")!);
        break;
      case 'notifications':
        appNavigator.push(Routes.notificationScreen);
        break;
      default:
        appNavigator.back();
        break;
    }
  }

  void onVehicleToggle() {
    if (currentIndex == 2 && childBase.runtimeType == HomeWidget){
      childBase = widgetOptions[3];
    } else {
      childBase = widgetOptions[2];
    }
    notifyListeners();
  }

  Widget getFirstButton(){
    if(childBase.runtimeType == VehicleMapWidget){
      return IconButton(
          style: ButtonStyle(
              backgroundColor:
              WidgetStateColor.resolveWith((states) => Colors.white)),
          onPressed: () => onVehicleToggle(),
          icon: const Icon(Icons.arrow_back,
              color: Color(0xFF6c18db), size: 30)
      );
    }
    return IconButton(
      icon: const Icon(Icons.menu,
      color: Colors.white, size: 30),
      onPressed: () {
        scaffoldKey.currentState?.openDrawer();
      }
    );
  }

  String formatRelativeTime(DateTime pastDate) {
    final now = DateTime.now();
    final difference = now.difference(pastDate);

    if (difference.inDays > 0) {
      return '${difference.inDays} ${difference.inDays == 1 ? 'día' : 'días'}';
    } else if (difference.inHours > 0) {
      return '${difference.inHours} ${difference.inHours == 1 ? 'hora' : 'horas'}';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes} ${difference.inMinutes == 1 ? 'minuto' : 'minutos'}';
    } else if (difference.inSeconds > 0) {
      return '${difference.inSeconds} ${difference.inSeconds == 1 ? 'segundo' : 'segundos'}';
    } else {
      return 'justo ahora';
    }
  }

  void onItemsTap(id) {
    switch (id) {
      case 0:
        currentIndex = id;
        selectedButton = filterButton!;
        notifyListeners();
        getTravels();
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
    childBase = widgetOptions[currentIndex];
  }

  void setGeoFence(GeoFence geoFence) {
    _homeServices.geoFence.value = geoFence;
    notifyListeners();
  }

  void deleteGeoFences(GeoFence geoFence) {
    viewModelLoading = true;
    notifyListeners();
    _geoFenceRepository.deleteGeoFence(geoFence.id).then((response){
        debugPrint(response.toString());
      if (response.status == Status.COMPLETED) {
        showPiDialog("Geocercca eliminada correctamente");
        _homeServices.getGeoFences();
      } else {
        throw response.apiException as ApiException;
      }
    }).catchError((error) {
      viewModelLoading = false;
      notifyListeners();
      showPiDialog(error);
    }).whenComplete(() {
      viewModelLoading = false;
      notifyListeners();
    });
  }

  Future<dynamic> geoFenceAction(BuildContext context, GeoFence geoFence){
    return showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text(
          "Atención",
          textAlign: TextAlign.center,
          style: TextStyle(
              color: Color(0xFF6c18db),
              fontSize: 25
          ),
        ),

        content: SizedBox(
          height: 200,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              MaterialButton(
                onPressed: (){
                  appNavigator.back();
                  setGeoFence(geoFence);
                  appNavigator.push(Routes.addGeoFence);
                },
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.edit, size: 30, color: Color(0xFF6c18db),),
                    SizedBox(width: 10),
                    Text("Editar", style: TextStyle(fontSize: 25, color: Color(0xFF6c18db))),
                  ],
                ),
              ),
              MaterialButton(
                onPressed: (){
                  appNavigator.back();
                  deleteGeoFences(geoFence);
                },
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.delete, size: 30, color: Colors.red,),
                    SizedBox(width: 10),
                    Text("Eliminar", style: TextStyle(fontSize: 25, color: Colors.red)),
                  ],
                ),
              ),
              MaterialButton(
                onPressed: (){
                  appNavigator.back();
                },
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.cancel_outlined, size: 30, color: Colors.black87),
                    SizedBox(width: 10),
                    Text("Cancelar", style: TextStyle(fontSize: 25, color: Colors.black87)),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void launchStreetView() async {
    // Construye la URL para Google Street View
    final coords = getVehicleCoordinates();
    final Uri streetViewUrl = Uri.parse(
        'google.streetview:cbll=${coords.latitude},${coords.longitude}&layer=c'
    );

    // Construye una URL de respaldo para el navegador web
    final Uri webUrl = Uri.parse(
        'https://www.google.com/maps/@?api=1&map_action=pano&viewpoint=${coords.latitude},${coords.longitude}'
    );

    try {
      // Intenta lanzar la URL nativa de Street View
      if (await canLaunchUrl(streetViewUrl)) {
        await launchUrl(streetViewUrl);
      }
      // Si falla, intenta abrir en el navegador
      else if (await canLaunchUrl(webUrl)) {
        await launchUrl(webUrl, mode: LaunchMode.externalApplication);
      } else {
        throw 'No se pudo lanzar ninguna URL';
      }
    } catch (e) {
      // Maneja cualquier excepción que pueda ocurrir
      print('Error al lanzar Street View: $e');
      // Aquí podrías mostrar un SnackBar o un diálogo de alerta al usuario
    }
  }

  void sendComand(String type){

    String command = type == "off" ? "Apagar" : "Encender";
    showDialog(
      context: scaffoldKey.currentState!.context,
      builder: (_) => AlertDialog(
        title: const Text(
          "Atención",
          textAlign: TextAlign.center,
          style: TextStyle(
              color: Color(0xFF6c18db),
              fontSize: 25
          ),
        ),

        content: SizedBox(
          height: 200,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              type == "off" ? const Text(
                "IMPORTANTE: ESTE COMANDO SOLO DEBE SER USADO EN CASO DE HURTO",
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Color(0xFF6c18db),
                    fontSize: 25
                ),
              ) : SizedBox.shrink(),
              Text(
                "¿Desea ejecutar el comando: $command motor?",
                textAlign: TextAlign.center,
                style: const TextStyle(
                    color: Colors.grey,
                    fontSize: 20
                ),
              ),
            ],
          ),
        ),
        actionsAlignment: MainAxisAlignment.spaceEvenly,
        actions: [
          MaterialButton(
            onPressed: () => appNavigator.back(),
            child: const Text("Cancelar", style: TextStyle(fontSize: 20, color: Colors.grey)),
          ),
          MaterialButton(
            onPressed: () {
              appNavigator.back();
              viewModelLoading = true;
              notifyListeners();

              viewModelLoading = false;
              notifyListeners();
              // _homeServices.sendCommand(type).then((response) {
              //   if (response.status == Status.COMPLETED) {
                  showPiDialog("Comando enviado correctamente");
              //   } else {
              //     throw response.apiException as ApiException;
              //   }
              // }).catchError((error) {
              //   showPiDialog(error);
              // }).whenComplete(() {
              //   viewModelLoading = false;
              //   notifyListeners();
              // });
            },
            child: const Text("Aceptar", style: TextStyle(fontSize: 20, color: Color(0xFF6c18db))),
          ),
        ],
      ),
    );
  }

  Future<dynamic> getTravels() async {
    String from = format.format(fromDate ?? DateTime.now().subtract(const Duration(days: 7))) + "Z";
    String to =  format.format(toDate ?? DateTime.now()) + "Z";
    viewModelLoading = true;
    notifyListeners();
    await _reportRepository.getTravels(
        vehicleId ?? "",
        from,
        to,
    ).then((response) async {
      if (response.status == Status.COMPLETED) {
        trips = response.data as List<Trip>;
      } else {
        throw response.apiException as ApiException;
      }
    }).catchError((error) {
      viewModelLoading = false;
      handleApiErrorDialog(error);
      notifyListeners();
    }).whenComplete((){
      viewModelLoading = false;
      notifyListeners();
    });
  }

  Future<dynamic> openFilter() {
    final context = scaffoldKey.currentContext!;
    final size = MediaQuery.of(context).size;
    return showDialog(
      barrierDismissible: false,
      context: context,
      builder: (_) => AlertDialog(
        actions: [
          MaterialButton(
              onPressed: (){
                appNavigator.back();
                getTravels();
              },
              child: Text(
                  "Aplicar",
                  style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontSize: 20
                  )
              )
          )
        ],
        content: SizedBox(
          height: size.height * 0.7,
          width: size.width * 0.9,
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  spacing: 10,
                  children: [
                    Text("Rangoo de fechas"),
                    FormBuilder(
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: FormBuilderRadioGroup(
                                    name: "rangos",
                                    options: [
                                      FormBuilderFieldOption(
                                          value: [
                                            DateTime.now().subtract(
                                                Duration(
                                                    hours: DateTime.now().hour,
                                                    minutes: DateTime.now().minute,
                                                    seconds: DateTime.now().second,
                                                    milliseconds: DateTime.now().millisecond
                                                )
                                            ),
                                            DateTime.now()
                                          ], child: Text("Hoy")
                                      ),
                                      FormBuilderFieldOption(
                                          value: [
                                            DateTime.now().subtract(
                                                Duration(
                                                    days: const Duration(days: 1).inDays,
                                                    hours: DateTime.now().hour,
                                                    minutes: DateTime.now().minute,
                                                    seconds: DateTime.now().second,
                                                    milliseconds: DateTime.now().millisecond
                                                )
                                            ),
                                            DateTime.now().subtract(
                                                Duration(
                                                    hours: DateTime.now().hour,
                                                    minutes: DateTime.now().minute,
                                                    seconds: DateTime.now().second,
                                                    milliseconds: DateTime.now().millisecond
                                                )
                                            )
                                          ],
                                          child: Text("Ayer")
                                      ),
                                      FormBuilderFieldOption(
                                          value: [
                                            DateTime.now().subtract(
                                                Duration(
                                                    days: const Duration(days: 7).inDays,
                                                    hours: DateTime.now().hour,
                                                    minutes: DateTime.now().minute,
                                                    seconds: DateTime.now().second,
                                                    milliseconds: DateTime.now().millisecond
                                                )
                                            ),
                                            DateTime.now().subtract(
                                                Duration(
                                                    hours: DateTime.now().hour,
                                                    minutes: DateTime.now().minute,
                                                    seconds: DateTime.now().second,
                                                    milliseconds: DateTime.now().millisecond
                                                )
                                            )
                                          ],
                                          child: Text("Ultimos 7 días")
                                      ),
                                      FormBuilderFieldOption(
                                          value: [
                                            DateTime.now().subtract(
                                                Duration(
                                                    days: const Duration(days: 30).inDays,
                                                    hours: DateTime.now().hour,
                                                    minutes: DateTime.now().minute,
                                                    seconds: DateTime.now().second,
                                                    milliseconds: DateTime.now().millisecond
                                                )
                                            ),
                                            DateTime.now().subtract(
                                                Duration(
                                                    hours: DateTime.now().hour,
                                                    minutes: DateTime.now().minute,
                                                    seconds: DateTime.now().second,
                                                    milliseconds: DateTime.now().millisecond
                                                )
                                            )
                                          ],
                                          child: Text("Ultimos 30 días")
                                      ),
                                    ],
                                    onChanged: (value){
                                      radioDates = value!;
                                      fromDate = value.first;
                                      toDate = value.last;
                                    },
                                  initialValue: radioDates,
                                ),
                              ),
                            ]
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: FormBuilderDateRangePicker(
                                  name: 'dates',
                                  firstDate: DateTime(0),
                                  lastDate:  DateTime.now(),
                                  decoration: const InputDecoration(
                                      icon: Icon(Icons.calendar_month)
                                  ),
                                  onChanged: (value) {
                                    if (value != null) {
                                      fromDate = value.start;
                                      toDate = value.end;
                                      radioDates = [];
                                    }
                                  },

                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<LatLng> getPositionsFromTrips(Trip trip) {
    if (trip.positions == null || trip.positions!.isEmpty) {
      return [];
    }
    return trip.positions!.map((position) => position.point()).toList();
  }

  Widget getTripMap(Trip trip, bool inactiveFlags) {

    return FlutterMap(
      options: MapOptions(
        interactionOptions: InteractionOptions(
            flags: inactiveFlags ? InteractiveFlag.none : InteractiveFlag.all
        ),
        initialCenter: trip.centerPoint(),
        initialZoom: 12,
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
                  point: trip.startPoint(),
                  child: const Icon(
                      Icons.location_on,
                      size: 50,
                      color: Colors.red
                  )
              ),
              Marker(
                  point: trip.endPoint(),
                  child: const Icon(
                      Icons.flag,
                      size: 50,
                      color: Colors.lightBlueAccent
                  )
              ),
            ]
        ),
        PolylineLayer(
          polylines: [
            Polyline(
              points: getPositionsFromTrips(trip),
              color: Colors.blue,
              strokeWidth: 4.0,
            ),
          ],
        ),
      ],
    );
  }

  Future<dynamic> userNotificationAction(BuildContext context, Trip trip) {
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
          child: getTripMap(trip, false),
        ),
      ),
    );
  }
}
