import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:smart_tracking/api/model/vehicle.dart';
import 'package:smart_tracking/geofences/view_model/geofences_view_model.dart';
import 'package:stacked/stacked.dart';
import 'package:smart_tracking/base/view_model/base_view_model.dart';
import 'package:smart_tracking/utils/app_component.dart';

import 'package:smart_tracking/utils/extensions/dialog.extension.dart';
import 'button_icon.dart';


class AddGeofenceScreen extends StackedView<GeoFencesViewModel> {

  const AddGeofenceScreen({super.key});

  @override
  Widget builder(BuildContext context, GeoFencesViewModel viewModel, Widget? child) {
    final size = MediaQuery.of(context).size;
    final args = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    viewModel.vehicle = args["vehicle"] as Vehicle;

    return Scaffold(
      body: Column(
        children: [
          // Header
          Container(
            padding: const EdgeInsets.only(top: 50, left: 16, right: 16, bottom: 12),
            color: Colors.lightBlue.shade300,
            width: double.infinity,
            child: Row(
              children: [
                IconButton(
                  style: ButtonStyle(
                    backgroundColor: WidgetStateColor.resolveWith((states) => Colors.white)
                  ),
                    onPressed: () => appNavigator.back(),
                    icon: const Icon(
                      Icons.arrow_back, color: Color(0xFF6c18db), size: 30
                    )
                ),
                const SizedBox(width: 12),
                const Text("Datos de la geocerca", style: TextStyle(color: Colors.white, fontSize: 18)),
              ],
            ),
          ),

          // Mapa
          SizedBox(
            height: size.height * 0.65,
            child: FlutterMap(
              options: MapOptions(
                initialCenter: viewModel.getVehicleCoordinates(),
                initialZoom: 14.0,
                onTap: (tapPosition, point) {
                  switch(viewModel.mode){
                    case GeofenceMode.recommended:
                      showPiDialog("Disponible pronto1");
                      break;
                    case GeofenceMode.free:
                      viewModel.addFreePoint(point);
                      break;
                    case GeofenceMode.circle:
                      viewModel.updateCenterCircle(point);
                      break;
                    default:
                      break;
                  }
                },
              ),
              children: [
                TileLayer(
                  urlTemplate: "https://tile.openstreetmap.org/{z}/{x}/{y}.png",
                  subdomains: const ['a', 'b', 'c'],
                ),
                viewModel.getMarkerShape(),
                viewModel.getMarkers(),
              ],
            ),
          ),

          // Botón Continuar
          viewModel.canContinue() ? Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF18BEDB),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
              ),
              onPressed: () {
                debugPrint("continuar: ${viewModel.getMarkerShape()}");
              },
              child: const Text("Continuar", style: TextStyle(color: Colors.white)),
            ),
          ) : const SizedBox(),
          if (viewModel.mode == GeofenceMode.circle)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            child: Column(
              children: [
                Slider(
                  value: viewModel.geofenceRadius,
                  min: 1000,
                  max: 7000,
                  onChanged: viewModel.setGeofenceRadius,
                ),
                const Text("Tamaño"),
              ],
            ),
          ),

          const Spacer(),

          // Menú inferior
          Container(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
            color: Colors.purple,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                viewModel.mode == null  || viewModel.mode == GeofenceMode.free ? BottomIcon(
                  icon: Icons.add_circle,
                  label: "Circulo",
                  onTap: () => viewModel.changeModeGeofence(GeofenceMode.circle),
                ) : const SizedBox(),
                viewModel.mode == null  || viewModel.mode == GeofenceMode.circle ? BottomIcon(
                  icon: Icons.edit,
                  label: "Dibujo libre",
                  onTap: () => viewModel.changeModeGeofence(GeofenceMode.free),
                ) : const SizedBox(),
                BottomIcon(
                  icon: Icons.recommend,
                  label: "Recomendado",
                  onTap: () => viewModel.changeModeGeofence(GeofenceMode.recommended),
                ),
                BottomIcon(
                  icon: Icons.delete,
                  label: "Eliminar",
                  onTap: viewModel.clearPolygon,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  GeoFencesViewModel viewModelBuilder(BuildContext context) {
    return GeoFencesViewModel(context);
  }
}