import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:smart_tracking/utils/disable_glow_scroll.dart';
import 'package:smart_tracking/widgets/loading.dart';

import 'package:smart_tracking/routes.dart';
import 'package:smart_tracking/utils/app_component.dart';
import '../widgets/drawer_widget.dart';
import 'package:stacked/stacked.dart';

class BaseScreen extends StatelessWidget {
  final GlobalKey<ScaffoldState>? scaffoldKey;
  final Widget body;
  final PreferredSizeWidget? appBar;
  final Widget? bottomNavigation;

  ///Used to overlap a loading widget over the main widget
  final bool isLoading;
  final WillPopCallback? onBackPressed;
  final bool resizeToAvoidBottomInset;
  final bool extendBody;
  final Widget? progress;
  final Color? backgroundColor;
  final Widget? fab;
  final Color? statusBarColor;
  final Brightness? statusBarTheme;
  final Color? systemNavigationBarColor;
  final bool topSafeArea;
  final bool showConectivity;
  final Color? onScrollStatusBarColor;
  final bool showErrorBody;
  final Widget? errorBody;

  ///Conditonal Rendering: If 'isLoadingWithoutOverlap = true' it will show the loading widget
  ///but not the main widget (without overlapping the main widget).
  final bool isLoadingWithoutOverlap;

  const BaseScreen({
    Key? key,
    this.scaffoldKey,
    required this.body,
    this.appBar,
    this.bottomNavigation,
    this.onBackPressed,
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
  }) : super(key: key);

  static EdgeInsets? deviceViewPadding;

  void _setInitialDeviceViewPadding(BuildContext context) {
    BaseScreen.deviceViewPadding ??= MediaQuery.of(context).viewPadding;
  }

  @override
  Widget build(BuildContext context) {
    _setInitialDeviceViewPadding(context);
    final child = (showErrorBody && errorBody != null) ? errorBody! : body;

    return KeyboardDismissOnTap(
      child: Container(
        color: onScrollStatusBarColor ?? backgroundColor ?? Colors.white,
        child: AnnotatedRegion<SystemUiOverlayStyle>(
          value: SystemUiOverlayStyle(
            statusBarColor: statusBarColor ?? Colors.transparent,
            systemNavigationBarColor: systemNavigationBarColor ?? Colors.white,
            statusBarBrightness: statusBarTheme ?? Brightness.light,
            statusBarIconBrightness: statusBarTheme ?? Brightness.light,
            systemNavigationBarIconBrightness:
                statusBarTheme ?? Brightness.light,
          ),
          child: WillPopScope(
            onWillPop: onBackPressed ?? () async => true,
            child: Stack(
              children: [
                Visibility(
                  visible: isLoading,
                  child: Loading(progress: progress),
                ),
                SafeArea(
                  top: topSafeArea,
                  child: Scaffold(
                    key: scaffoldKey,
                    resizeToAvoidBottomInset: resizeToAvoidBottomInset,
                    extendBody: extendBody,
                    backgroundColor: backgroundColor ?? Colors.white,
                    appBar: appBar,
                    drawer: DrawerWidget((id) {
                      if (id == 'home') {
                        Navigator.pop(context);
                      } else {
                        appNavigator.pushReplacement(Routes.login);
                      }
                    }),
                    floatingActionButton: fab,
                    bottomNavigationBar: BottomNavigationBar(
                      fixedColor: const Color(0xFF6c18db),
                      iconSize: 70,
                      type: BottomNavigationBarType.fixed,
                      currentIndex: 2,
                      onTap: (index) {
                        switch (index) {
                          case 0:
                            appNavigator.push(Routes.history);
                            break;
                          case 1:
                            appNavigator.push(Routes.home);
                            break;
                          case 2:
                            appNavigator.back();
                            break;
                          case 3:
                            appNavigator.push(Routes.home);
                            break;
                          case 4:
                            appNavigator.push(Routes.home);
                            break;
                        }
                      },

                      items: [
                        const BottomNavigationBarItem(
                            icon: Icon(
                              Icons.history,
                              color: Color(0xFF6c18db),
                            ),
                            tooltip: 'Historial',
                            label: 'Historial'
                        ),
                        const BottomNavigationBarItem(
                            icon: Icon(
                              Icons.map,
                              color: Color(0xFF6c18db),
                            ),
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
                            icon: Icon(
                              Icons.calendar_month,
                              color: Color(0xFF6c18db),
                            ),
                            label: 'Renovación',
                            tooltip: 'Renovación',
                        ),
                        const BottomNavigationBarItem(
                            icon: Icon(
                              Icons.support_agent,
                              color: Color(0xFF6c18db),
                            ),
                            label: 'Soporte',
                            tooltip: 'Soporte'
                        ),
                      ],
                    ),
                    body: Container(
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('assets/images/background.png'),
                          fit: BoxFit.cover,
                        ),
                      ),
                      child: Container(
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
                                  :
                              child,
                            ),
                            Positioned(
                                top: 30,
                                child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      IconButton(
                                          icon: const Icon(
                                            Icons.menu, color: Colors.white,
                                            size: 45
                                          ),
                                          onPressed: () {
                                            scaffoldKey?.currentState?.openDrawer();
                                          }
                                      ),

                                      //crear lista desplegable con opción de 'vehiculo 1'
                                      DropdownButton(
                                        padding: EdgeInsets.only(left: 100),
                                        style: const TextStyle(
                                          color: Colors.grey,
                                          backgroundColor: Colors.white,
                                          fontSize: 20,
                                        ),
                                        dropdownColor: Colors.white,
                                        borderRadius: BorderRadius.circular(10),

                                        value: 'Vehiculo 1',
                                        items: <String>['Vehiculo 1', 'Vehiculo 2'].map((String value) {
                                          return DropdownMenuItem<String>(
                                            value: value,
                                            child: Text(value),
                                          );
                                        }).toList(), onChanged: (String? value) {  },
                                        icon: const Icon(Icons.keyboard_arrow_down, color: Colors.white, size: 45),
                                      ),
                                      IconButton(
                                          padding: EdgeInsets.only(left: 60),
                                          icon: Icon(Icons.notifications, color: Colors.white, size: 45),
                                          onPressed: () {
                                            Placeholder();

                                          }
                                      ),


                                    ]
                                )
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}