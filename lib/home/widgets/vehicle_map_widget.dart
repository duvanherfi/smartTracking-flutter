import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:smart_tracking/base/view_model/base_screen_view_model.dart';
import 'package:smart_tracking/home/widgets/status_card.dart';
import 'package:smart_tracking/routes.dart';
import 'package:smart_tracking/utils/app_component.dart';
import 'package:smart_tracking/widgets/content_oval.dart';
import 'package:stacked/stacked.dart';

class VehicleMapWidget extends ViewModelWidget<BaseScreenViewModel> {
  const VehicleMapWidget({super.key});


  @override
  Widget build(BuildContext context, BaseScreenViewModel viewModel) {
    final size = MediaQuery.of(context).size;
    return Column(
      children: [
        Stack(
          children: [
            SizedBox(
              height: size.height * 0.75,
              child: FlutterMap(
                key: viewModel.mapKey,
                options: MapOptions(
                  initialCenter: viewModel.getVehicleCoordinates(),
                  initialZoom: 14.0,
                ),
                children: [
                  TileLayer(
                    urlTemplate: "https://tile.openstreetmap.org/{z}/{x}/{y}.png",
                    subdomains: const ['a', 'b', 'c'],
                  ),
                  MarkerLayer(
                      markers: [
                        Marker(
                            point: viewModel.getVehicleCoordinates(),
                            child: const Image(
                                image: AssetImage("assets/images/moto.png"),
                                height: 100,
                            )
                        )
                      ]
                  )
                ],
              ),
            ),
            Positioned(
              top: 30,
                left: 10,
                child: ContentOval(
                    width: 80,
                    height: 80,
                  firtsBorderColor: Color(0xFF6c18db),
                  secondBorderColor: Colors.white,
                  secondBorderWidth: 5,
                  backgroudnColor: Color(0xFF1942DB),
                    child: IconButton(
                        onPressed: viewModel.launchStreetView,
                        icon: const Icon(
                          Icons.streetview, size: 25,
                          color: Colors.white,
                        )
                    ),
                )
            ),
            Positioned(
                top: 120,
                left: 10,
                child: ContentOval(
                  width: 80,
                  height: 80,
                  firtsBorderColor: Color(0xFF6c18db),
                  secondBorderColor: Colors.white,
                  secondBorderWidth: 5,
                  backgroudnColor: Color(0xFF1942DB),
                  child: IconButton(
                      onPressed: (){
                        viewModel.sendComand("off");
                      },
                      icon: const Icon(
                        Icons.play_arrow_rounded, size: 25,
                        color: Colors.white,
                      )
                  ),
                )
            ),
            Positioned(
                top: 210,
                left: 10,
                child: ContentOval(
                  width: 80,
                  height: 80,
                  firtsBorderColor: Color(0xFF6c18db),
                  secondBorderColor: Colors.white,
                  secondBorderWidth: 5,
                  backgroudnColor: Color(0xFF1942DB),
                  child: IconButton(
                      onPressed: (){
                        viewModel.sendComand("on");
                      },
                      icon: const Icon(
                        Icons.stop, size: 25,
                        color: Colors.white,
                      )
                  ),
                )
            ),
            Positioned(
                top: 300,
                left: 10,
                child: ContentOval(
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
            ),
          ],
        ),
        StatusCard(
            speed: viewModel.vehicle?.maxSpeed,
            lastUpdateTime: viewModel.vehicle?.lastUpdateFromGps
        )
      ]
    );
  }
}
