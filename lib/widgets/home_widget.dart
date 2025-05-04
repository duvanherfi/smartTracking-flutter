import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:smart_tracking/utils/app_component.dart';
import 'package:stacked/stacked.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:smart_tracking/base/view_model/base_view_model.dart';
import 'package:smart_tracking/widgets/content_oval.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

import 'custom_tag.dart';

class HomeWidget extends ViewModelWidget<BaseScreenViewModel> {

  const HomeWidget({super.key});

  @override
  Widget build(
      BuildContext context, BaseScreenViewModel viewModel) {
    viewModel.selectedButton = viewModel.notificationsButton!;
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          children: [
            BubbleTag(
              text: viewModel.vehicle?.labelDirection?.toString() ?? "Cargando...",
            ),
            const SizedBox(width: 90),
            Stack(
              children: [
                ContentOval(
                  width: 150,
                  height: 150,
                  firtsBorderWidth: 0,
                  secondBorderWidth: 0,
                  child: FlutterMap(
                    options: MapOptions(
                      initialCenter: viewModel.getVehicleCoordinates(),
                      initialZoom: 9.2,
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
                ),
              ],
            ),
            SizedBox(width: 20),
          ],
        ),
        SizedBox(height: 30),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              children: [
                SizedBox(
                  width: 180,
                  height: 180,
                  child: SfRadialGauge(
                      enableLoadingAnimation: true,
                      axes: <RadialAxis>[
                        RadialAxis(
                            minimum: 0,
                            maximum: 200,
                            interval: 20,
                            radiusFactor: 1,
                            canScaleToFit: true,
                            maximumLabels: 6,
                            showLastLabel: true,
                            showTicks: false,
                            axisLineStyle: const AxisLineStyle(
                                thickness: 20,
                                color: Colors.white,
                                cornerStyle: CornerStyle.bothCurve
                            ),
                            axisLabelStyle: const GaugeTextStyle(
                                color: Colors.white,
                                fontSize: 9,
                                fontWeight: FontWeight.bold
                            ),
                            ranges: const <GaugeRange>[

                            ],
                            pointers: <GaugePointer>[
                              RangePointer(
                                width: 20,
                                value: double.tryParse(viewModel.vehicle?.maxSpeed?.toString() ?? "0") as double,
                                cornerStyle: CornerStyle.bothCurve,
                                enableAnimation: true,
                                color: const Color(0xFF6C18DB),

                              )
                            ],
                            annotations: <GaugeAnnotation>[
                              GaugeAnnotation(
                                  widget:  ContentOval(
                                    width: 70,
                                    height: 70,
                                    secondBorderWidth: 0,
                                    backgroudnColor: Color(0xFF6C18DB),
                                    firtsBorderWidth: 0,
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text(
                                            viewModel.vehicle?.maxSpeed?.toString() ?? "0",
                                            style: const TextStyle(
                                                color: Colors.white, fontSize: 20
                                            )
                                        ),
                                        const Text(
                                            'KM/H',
                                            style: TextStyle(
                                                color: Colors.white, fontSize: 10
                                            )
                                        )
                                      ],
                                    ),
                                  ),
                                  angle: 90,
                                  positionFactor: 0
                              )
                            ]),
                      ]
                  ),
                ),
                const Text(
                  "Velocidad máxima \nalcanzada hoy",
                  maxLines: 2, textAlign: TextAlign.center,
                )
              ],
            )
          ],
        ),
        const SizedBox(height: 30),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ContentOval(
              width: 100,
              height: 100,
              backgroudnColor: Color(0xFF1942DB),
              child: const Text('1',
                  style: TextStyle(color: Colors.white, fontSize: 20)),
            ),
            Column(
              children: [
                ContentOval(
                  width: 100,
                  height: 100,
                  backgroudnColor: Color(0xFF1942DB),
                  child: const Text('1',
                      style: TextStyle(color: Colors.white, fontSize: 20)),
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
                  style: TextStyle(color: Colors.white, fontSize: 20)),
            )
          ],
        ),
      ],
    );
  }
}
