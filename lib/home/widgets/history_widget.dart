import 'package:flutter/material.dart';
import 'package:smart_tracking/base/view_model/base_screen_view_model.dart';
import 'package:smart_tracking/home/widgets/trip_card.dart';
import 'package:smart_tracking/utils/extensions/string_extensions.dart';
import 'package:stacked/stacked.dart';
import 'package:dynamic_tabbar/dynamic_tabbar.dart';

class HistoryWidget extends ViewModelWidget<BaseScreenViewModel> {
  const HistoryWidget({super.key});


  @override
  Widget build(BuildContext context, BaseScreenViewModel viewModel)  {


    return  DynamicTabBarWidget(
      dynamicTabs: [
        TabData(
            index: 0,
            title: const Tab(
              text: "Viajes",
            ),
            content: travels(context, viewModel)
        ),
        TabData(
          index: 1,
          title: const Tab(
            text: "Resumen",
          ),
          content: summary(context, viewModel)
        ),
      ],
      onTabControllerUpdated: (tabController) { tabController;  },
    );
  }

  Widget summary(BuildContext context, BaseScreenViewModel viewModel) {
    const style = TextStyle(
        fontSize: 25,
        color: Colors.white,
        fontWeight: FontWeight.bold
    );
    return SizedBox(
        child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 20),
            child: Center(
                child: Column(
                  spacing: 10,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Expanded(
                          child: Text(
                            "Velocidad Maxima:",
                            style: style,
                          ),
                        ),
                        Text(
                          "${viewModel.vehicle?.maxSpeed?.toInt() ?? 0} km/h",
                          style: style,
                        )
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Expanded(
                          child: Text(
                            "Velocidad promedio: ",
                            style: style,
                          ),
                        ),
                        Text(
                          "${viewModel.vehicle?.averageSpeed?.toInt() ?? 0} km/h",
                          style: style,
                        )
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Expanded(
                            child:  Text(
                              "Intesidad de Señal: ",
                              style: style,
                            )
                        ),
                        Text(
                          "${viewModel.vehicle?.rssi ?? 0}",
                          style: style,
                        )
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Expanded(
                            child:  Text(
                              "Nivel de batería: ",
                              style: style,
                            )
                        ),
                        Text(
                          "${viewModel.vehicle?.batteryLevel ?? 0}%",
                          style: style,
                        )
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Expanded(
                            child:  Text(
                              "Encendido: ",
                              style: style,
                            )
                        ),
                        Text(
                          viewModel.vehicle?.ignition ?? false ? "Si" : "No",
                          style: style,
                        )
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Expanded(
                            child:  Text(
                              "Distancia recorrida: ",
                              style: style,
                            )
                        ),
                        Text(
                          "${(double.parse(viewModel.vehicle?.totalDistance! ?? "0") / 1000).toStringAsFixed(2)} km",
                          style: style,
                        )
                      ],
                    ),
                  ],
                )
            )
        )
    );
  }

  Widget travels(BuildContext context, BaseScreenViewModel viewModel) {
    return viewModel.trips.isNotEmpty
        ? SizedBox(
      child: Padding(
        padding: const EdgeInsets.only(bottom: 3, top: 1),
        child: ListView.builder(
          itemCount: viewModel.trips.length,
          controller: ScrollController(),
          shrinkWrap: true,
          itemBuilder: (_, index) {
            return GestureDetector(
              onTap: () {
                viewModel.userNotificationAction(context, viewModel.trips[index] as dynamic);
              },
              child: TripCard(
                  trip: viewModel.trips[index]
              ),
            );
          },
        ),
      ),
    )
        : const Center(
      child: Text(
        'No hay viajes',
        style: TextStyle(fontSize: 20),
      ),
    );
  }
}
