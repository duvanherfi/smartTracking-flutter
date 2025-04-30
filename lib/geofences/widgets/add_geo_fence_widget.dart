import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:stacked/stacked.dart';
import 'package:smart_tracking/base/view_model/base_view_model.dart';
import 'package:smart_tracking/utils/app_component.dart';

import 'package:smart_tracking/utils/extensions/dialog.extension.dart';
import 'button_icon.dart';


class AddGeofenceScreen extends ViewModelWidget<BaseScreenViewModel> {

  const AddGeofenceScreen({super.key});

  @override
  Widget build(BuildContext context, BaseScreenViewModel viewModel) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: Column(
        children: [
          // Header
          Container(
            padding: const EdgeInsets.only(top: 50, left: 16, right: 16, bottom: 12),
            color: Colors.lightBlue.shade300,
            width: double.infinity,
            child: const Row(
              children: [
                Icon(Icons.arrow_back, color: Colors.white),
                SizedBox(width: 12),
                Text("Datos de la geocerca", style: TextStyle(color: Colors.white, fontSize: 18)),
              ],
            ),
          ),

          // Mapa
          SizedBox(
            height: size.height * 0.5,
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
                  urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                  subdomains: const ['a', 'b', 'c'],
                ),
                if (viewModel.mode == GeofenceMode.circle)
                  CircleLayer(
                    circles: [
                      CircleMarker(
                        point: viewModel.centerCircle,
                        color: Colors.red.withValues(alpha: 0.3),
                        borderStrokeWidth: 2,
                        borderColor: Colors.red,
                        useRadiusInMeter: true,
                        radius: viewModel.geofenceRadius,
                      )
                    ],
                  ),
                if (viewModel.mode == GeofenceMode.free &&
                    viewModel.freePolygon.isNotEmpty)
                  PolygonLayer(
                    polygons: [
                      Polygon(
                        points: viewModel.freePolygon,
                        color: Colors.red.withValues(alpha: 0.3),
                        borderColor: Colors.red,
                        borderStrokeWidth: 2,
                      ),
                    ],
                  ),
              ],
            ),
          ),

          // Botón Continuar
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.lightBlue.shade300,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
              ),
              onPressed: () {
                // Acción al presionar continuar
              },
              child: const Text("Continuar", style: TextStyle(color: Colors.white)),
            ),
          ),

          // Slider de tamaño
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            child: Column(
              children: [
                Slider(
                  value: viewModel.geofenceRadius,
                  min: 100,
                  max: 1000,
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
                BottomIcon(
                  icon: Icons.add_circle,
                  label: "Circulo",
                  onTap: () => viewModel.changeModeGeofence(GeofenceMode.circle),
                ),
                BottomIcon(
                  icon: Icons.edit,
                  label: "Dibujo libre",
                  onTap: () => viewModel.changeModeGeofence(GeofenceMode.free),
                ),
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
}