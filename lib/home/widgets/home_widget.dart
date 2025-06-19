import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:smart_tracking/base/view_model/base_screen_view_model.dart';
import 'package:smart_tracking/routes.dart';
import 'package:smart_tracking/utils/app_component.dart';
import 'package:smart_tracking/widgets/content_oval.dart';
import 'package:stacked/stacked.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:smart_tracking/widgets/custom_tag.dart';

class HomeWidget extends ViewModelWidget<BaseScreenViewModel> {

  const HomeWidget({super.key});

  @override
  Widget build(BuildContext context, BaseScreenViewModel viewModel) {
    final size = MediaQuery.of(context).size;

    viewModel.selectedButton = viewModel.notificationsButton!;

    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          children: [
            SizedBox(width: size.width * 0.05),
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
                      interactionOptions: InteractionOptions(
                          flags: InteractiveFlag.none
                      ),
                      onTap: (_, __){
                        viewModel.onVehicleToggle();
                      },
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
                  width: size.width * 0.3,
                  height: 180,
                  child: SfRadialGauge(
                      axes: <RadialAxis>[
                        RadialAxis(
                            minimum: 0,
                            maximum: 100,
                            radiusFactor: 0.9,
                            canScaleToFit: true,
                            maximumLabels: 6,
                            showLastLabel: false,
                            showTicks: false,
                            axisLineStyle: const AxisLineStyle(
                                thickness: 0,
                                color: Colors.white,
                                cornerStyle: CornerStyle.bothCurve
                            ),
                            axisLabelStyle: const GaugeTextStyle(
                                color: Colors.white,
                                fontSize: 0,
                                fontWeight: FontWeight.bold
                            ),
                            pointers: const <GaugePointer>[
                              RangePointer(
                                width: 13,
                                value: 75,
                                cornerStyle: CornerStyle.bothCurve,
                                color: Color(0xFF6C18DB),
                              )
                            ],
                            annotations: <GaugeAnnotation>[
                              GaugeAnnotation(
                                  widget:  ContentOval(
                                    width: 100,
                                    height: 100,
                                    secondBorderWidth: 0,
                                    backgroudnColor: Colors.transparent,
                                    firtsBorderWidth: 0,
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        const Text(
                                            "Tiempo",
                                            style: TextStyle(
                                                color: Colors.white, fontSize: 15
                                            )
                                        ),
                                        Text(
                                            "00:00",
                                            style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                              overflow: TextOverflow.clip
                                            )
                                        ),
                                        const Text(
                                            'HH:MM',
                                            style: TextStyle(
                                                color: Colors.white, fontSize: 15
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
              ],
            ),
            Column(
              children: [
                SizedBox(
                  width: size.width * 0.37,
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
                                value: viewModel.vehicle?.maxSpeed ?? 0,
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
                                            viewModel.vehicle?.maxSpeed?.toInt().toString() ?? "0",
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
            ),
            Column(
              children: [
                SizedBox(
                  width: size.width * 0.3,
                  height: 180,
                  child: SfRadialGauge(
                      axes: <RadialAxis>[
                        RadialAxis(
                            minimum: 0,
                            maximum: 100,
                            radiusFactor: 0.9,
                            canScaleToFit: true,
                            maximumLabels: 6,
                            showLastLabel: false,
                            showTicks: false,
                            isInversed: true,
                            axisLineStyle: const AxisLineStyle(
                                thickness: 0,
                                color: Colors.white,
                                cornerStyle: CornerStyle.bothCurve
                            ),
                            axisLabelStyle: const GaugeTextStyle(
                                color: Colors.white,
                                fontSize: 0,
                                fontWeight: FontWeight.bold
                            ),
                            pointers: const <GaugePointer>[
                              RangePointer(
                                width: 13,
                                value: 75,
                                cornerStyle: CornerStyle.bothCurve,
                                color: Color(0xFF6C18DB),

                              )
                            ],
                            annotations: <GaugeAnnotation>[
                              GaugeAnnotation(
                                  widget:  ContentOval(
                                    width: 100,
                                    height: 100,
                                    secondBorderWidth: 0,
                                    backgroudnColor: Colors.transparent,
                                    firtsBorderWidth: 0,
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        const Text(
                                            "Distancia",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 15
                                            )
                                        ),
                                        Text(
                                            (
                                                double.tryParse(
                                                    (viewModel.vehicle?.
                                                    totalDistance! ?? 0 ).toString()
                                                )! / 1000
                                            ).toInt().toString(),
                                            style: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold
                                            )
                                        ),
                                        const Text(
                                            'Km',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 15
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
              ],
            ),
          ],
        ),
        const SizedBox(height: 30),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ContentOval(
              width: 80,
              height: 80,
              child: IconButton(
                  onPressed: (){
                    viewModel.sendComand("off");
                  },
                  icon: Icon(
                    Icons.stop, size: 25,
                    color: Colors.white,
                  )
              ),
              firtsBorderColor: Color(0xFF6c18db),
              secondBorderColor: Colors.white,
              secondBorderWidth: 5,
              backgroudnColor: Color(0xFF1942DB),
            ),
            Column(
              children: [
                ContentOval(
                  width: 80,
                  height: 80,
                  child: IconButton(
                      onPressed: (){
                        viewModel.sendComand("on");
                      },
                      icon: Icon(
                        Icons.play_arrow, size: 25,
                        color: Colors.white,
                      )
                  ),
                  firtsBorderColor: Color(0xFF6c18db),
                  secondBorderColor: Colors.white,
                  secondBorderWidth: 5,
                  backgroudnColor: Color(0xFF1942DB),
                ),
                SizedBox(
                  height: 70,
                )
              ],
            ),
            ContentOval(
              width: 80,
              height: 80,
              firtsBorderColor: Color(0xFF6c18db),
              secondBorderColor: Colors.white,
              secondBorderWidth: 5,
              backgroudnColor: Color(0xFF1942DB),
              child: IconButton(
                  onPressed: (){
                    appNavigator.push(Routes.share);
                  },
                  icon: const Icon(
                    Icons.share, size: 25,
                    color: Colors.white,
                  )
              ),
            )
          ],
        ),
      ],
    );
  }
}
