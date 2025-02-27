import 'package:flutter/material.dart';
import 'package:smart_tracking/screens/base_screen.dart';
import 'package:smart_tracking/widgets/splash_widget.dart';
import 'package:list_wheel_scroll_view_nls/list_wheel_scroll_view_nls.dart';
import 'package:smart_tracking/home/view_model/home_view_model.dart';
import 'package:smart_tracking/widgets/content_oval.dart';
import 'package:stacked/stacked.dart';
import 'package:smart_tracking/widgets/app_lifecycle_controller_widget.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:latlong2/latlong.dart';

class HomeScreen extends StackedView<HomeViewModel> {
  const HomeScreen({super.key});

  static var chilKey = UniqueKey();

  @override
  Widget builder(
    BuildContext context,
    HomeViewModel viewModel,
    Widget? child,
  ) =>
      AppLifeCycleControllerWidget(
        onDidChangeAppLifecycleState: (AppLifecycleState) {},
        child: (viewModel.loading)
            ? const SplashWidget()
            : ViewModelBuilder<HomeViewModel>.reactive(
                viewModelBuilder: () => HomeViewModel(context),
                builder: (context, homeViewModel, child) => BaseScreen(
                    scaffoldKey: homeViewModel.scaffoldKey,
                    topSafeArea: false,
                    statusBarColor: null,
                    body: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Stack(
                              children: [
                                ContentOval(
                                  width: 150,
                                  height: 150,
                                  firtsBorderWidth: 0,
                                  secondBorderWidth: 0,
                                  child: FlutterMap(
                                    options: MapOptions(
                                      initialCenter:
                                          LatLng(51.509364, -0.128928),
                                      // Center the map over London
                                      initialZoom: 9.2,
                                    ),
                                    children: [
                                      TileLayer(
                                        // Bring your own tiles
                                        urlTemplate:
                                            'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                                        // For demonstration only
                                        userAgentPackageName:
                                            'com.example.app', // Add your app identifier
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
                                    ],
                                  ),
                                ),
                                const Positioned(
                                    bottom: 0,
                                    right: 1,
                                    child: ContentOval(
                                      width: 50,
                                      height: 50,
                                      backgroudnColor: Colors.deepPurple,
                                      firtsBorderWidth: 3,
                                      secondBorderWidth: 0,
                                      child: Icon(
                                          Icons.location_on_outlined,
                                        size: 38,
                                        color: Colors.white,
                                      ),
                                    )
                                )
                              ],
                            ),
                            SizedBox(width: 20),
                          ],
                        ),
                        SizedBox(height: 70),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            ContentOval(
                              width: 100,
                              height: 100,
                              backgroudnColor: Color(0xFF1942DB),
                              child: const Text('1',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 20)),
                            ),
                            Column(
                              children: [
                                ContentOval(
                                  width: 100,
                                  height: 100,
                                  backgroudnColor: Color(0xFF1942DB),
                                  child: const Text('1',
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 20)),
                                ),
                                SizedBox(
                                  height: 70,
                                )
                              ],
                            ),
                            ContentOval(
                              width: 100,
                              height: 100,
                              backgroudnColor: Color(0xFF1942DB),
                              child: const Text('1',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 20)),
                            )
                          ],
                        )
                      ],
                    )),
              ),
      );

  @override
  HomeViewModel viewModelBuilder(BuildContext context) =>
      HomeViewModel(context);
}
