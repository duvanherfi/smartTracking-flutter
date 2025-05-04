import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:smart_tracking/api/model/vehicle.dart';
import 'package:smart_tracking/base/view_model/base_view_model.dart';
import 'package:smart_tracking/geofences/widgets/geofence_widget.dart';
import 'package:smart_tracking/utils/disable_glow_scroll.dart';
import 'package:smart_tracking/widgets/drawer_widget.dart';
import 'package:smart_tracking/widgets/history_widget.dart';
import 'package:smart_tracking/widgets/home_widget.dart';
import 'package:smart_tracking/widgets/loading.dart';
import 'package:stacked/stacked.dart';

class BaseScreen extends StackedView<BaseScreenViewModel> {
  Widget? body;
  PreferredSizeWidget? appBar;
  Widget? bottomNavigation;

  ///Used to overlap a loading widget over the main widget
  bool isLoading;
  bool resizeToAvoidBottomInset;
  bool extendBody;
  Widget? progress;
  Color? backgroundColor;
  Widget? fab;
  Color? statusBarColor;
  Brightness? statusBarTheme;
  Color? systemNavigationBarColor;
  bool topSafeArea;
  bool showConectivity;
  Color? onScrollStatusBarColor;
  bool showErrorBody;
  Widget? errorBody;

  ///Conditonal Rendering: If 'isLoadingWithoutOverlap = true' it will show the loading widget
  ///but not the main widget (without overlapping the main widget).
  bool isLoadingWithoutOverlap;

  BaseScreen({
    super.key,
    this.body,
    this.appBar,
    this.bottomNavigation,
    this.isLoading = false,
    this.resizeToAvoidBottomInset = false,
    this.extendBody = false,
    this.progress,
    this.backgroundColor,
    this.fab,
    this.statusBarColor,
    this.statusBarTheme,
    this.systemNavigationBarColor,
    this.topSafeArea = true,
    this.showConectivity = true,
    this.isLoadingWithoutOverlap = false,
    this.onScrollStatusBarColor,
    this.showErrorBody = false,
    this.errorBody,
  });

  static EdgeInsets? deviceViewPadding;

  void _setInitialDeviceViewPadding(BuildContext context) {
    BaseScreen.deviceViewPadding ??= MediaQuery.of(context).viewPadding;
  }

  @override
  Widget builder(
      BuildContext context, BaseScreenViewModel viewModel, Widget? child) {
    final List<Widget> widgetOptions = <Widget>[
      const HistoryWidget(),
      const GeofenceWidget(),
      const HomeWidget()
    ];

    Widget childBase = (showErrorBody && errorBody != null)
        ? errorBody!
        : widgetOptions[viewModel.currentIndex];

    _setInitialDeviceViewPadding(context);

    // TODO: implement builder
    return Container(
      color: onScrollStatusBarColor ?? backgroundColor ?? Colors.white,
      child: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle(
          statusBarColor: statusBarColor ?? Colors.transparent,
          systemNavigationBarColor: systemNavigationBarColor ?? Colors.white,
          statusBarBrightness: statusBarTheme ?? Brightness.light,
          statusBarIconBrightness: statusBarTheme ?? Brightness.light,
          systemNavigationBarIconBrightness: statusBarTheme ?? Brightness.light,
        ),
        child: Stack(
          children: [
            Visibility(
              visible: isLoading,
              child: Loading(progress: progress),
            ),
            SafeArea(
              top: topSafeArea,
              child: Scaffold(
                key: viewModel.scaffoldKey,
                resizeToAvoidBottomInset: resizeToAvoidBottomInset,
                extendBody: extendBody,
                backgroundColor: backgroundColor ?? Colors.white,
                appBar: appBar,
                drawer: DrawerWidget(viewModel.onDrawerTap),
                floatingActionButton: fab,
                bottomNavigationBar: BottomNavigationBar(
                  iconSize: 70,
                  type: BottomNavigationBarType.fixed,
                  currentIndex: viewModel.currentIndex,
                  enableFeedback: true,
                  selectedItemColor: Color(0xFF18BEDB),
                  unselectedItemColor: Color(0xFF6c18db),
                  onTap: viewModel.onitemsTap,
                  items: [
                    const BottomNavigationBarItem(
                      icon: Icon(Icons.history),
                      tooltip: 'Historial',
                      label: 'Historial',
                    ),
                    const BottomNavigationBarItem(
                      icon: Icon(Icons.map),
                      label: 'Geocercas',
                      tooltip: 'Geocercas',
                    ),
                    BottomNavigationBarItem(
                      icon: Image.asset(
                        'assets/images/logo.png',
                      ),
                      label: '',
                      tooltip: 'Inicio',
                    ),
                    const BottomNavigationBarItem(
                      icon: Icon(Icons.calendar_month),
                      label: 'Renovación',
                      tooltip: 'Renovación',
                    ),
                    const BottomNavigationBarItem(
                        icon: Icon(Icons.support_agent),
                        label: 'Soporte',
                        tooltip: 'Soporte'),
                  ],
                ),
                body: Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/images/background.png'),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    decoration: BoxDecoration(
                      color: const Color(0xFF18BEDB).withOpacity(0.88),
                    ),
                    child: Stack(
                      alignment: Alignment.centerLeft,
                      children: [
                        disableGlow(
                          isLoadingWithoutOverlap
                              ? Loading(
                            progress: progress,
                            backgroundColor: Colors.grey.withOpacity(0.2),
                          )
                              : Container(
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.height,
                            padding: const EdgeInsets.only(
                                top: 100, left: 20, right: 20
                            ),
                            child: childBase,
                          ),
                        ),
                        Positioned(
                            top: 30,
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  IconButton(
                                      icon: const Icon(Icons.menu,
                                          color: Colors.white, size: 45),
                                      onPressed: () {
                                        viewModel.scaffoldKey.currentState?.openDrawer();
                                      }),
                                  const Padding(
                                      padding:
                                      EdgeInsets.symmetric(horizontal: 50)),

                                  //crear lista desplegable con opción de 'vehiculo 1'
                                  DropdownButton(
                                    padding: EdgeInsets.all(0),
                                    style: const TextStyle(
                                      color: Color(0xFF6c18db),
                                      backgroundColor: Colors.white,
                                      fontSize: 20,
                                    ),
                                    dropdownColor: Colors.white,
                                    borderRadius: BorderRadius.circular(10),
                                    value: viewModel.vehicleId,
                                    items: viewModel.vehicles
                                        .map((Vehicle vehicle) {
                                      return DropdownMenuItem<String>(
                                        value: vehicle.id,
                                        child: Text(vehicle.plates?.toString() ?? ""),
                                      );
                                    }).toList(),
                                    onChanged: viewModel.onVehicleTap,
                                    icon: const Icon(Icons.keyboard_arrow_down,
                                        color: Color(0xFF6c18db), size: 45),
                                    menuMaxHeight: 200,
                                  ),
                                  const Padding(
                                      padding:
                                      EdgeInsets.symmetric(horizontal: 40)
                                  ),
                                  viewModel.selectedButton,
                                ])),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  BaseScreenViewModel viewModelBuilder(BuildContext context) {
    return BaseScreenViewModel(context);
  }
}
