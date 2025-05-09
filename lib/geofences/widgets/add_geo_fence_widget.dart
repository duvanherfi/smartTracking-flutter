import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:smart_tracking/api/model/vehicle.dart';
import 'package:smart_tracking/geofences/view_model/geofences_view_model.dart';
import 'package:smart_tracking/widgets/splash_widget.dart';
import 'package:stacked/stacked.dart';
import 'package:multiselect/multiselect.dart';
import 'package:smart_tracking/utils/app_component.dart';


class AddGeofenceScreen extends StackedView<GeoFencesViewModel> {
  const AddGeofenceScreen({super.key});

  @override
  Widget builder(
      BuildContext context, GeoFencesViewModel viewModel, Widget? child) {
    final args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    viewModel.setVehiclesInfo(args);

    return Scaffold(
      key: viewModel.scaffoldKey,
      appBar: AppBar(
        title: const Text("Datos de la geocerca",
            style: TextStyle(color: Colors.white, fontSize: 18)
        ),
        backgroundColor: Color(0xFF18BEDB),
        leading: IconButton(
            style: ButtonStyle(
                backgroundColor:
                    WidgetStateColor.resolveWith((states) => Colors.white)),
            onPressed: viewModel.back,
            icon: const Icon(Icons.arrow_back,
                color: Color(0xFF6c18db), size: 30)
        ),
      ),
      body: showBody(context, viewModel),
      bottomNavigationBar: viewModel.navigationBar(),
    );
  }

  Widget showBody(context, viewModel) {
    if (viewModel.loading) {
      return const SplashWidget();
    } else if (viewModel.showForm){
      return showForm(context, viewModel);
    } else {
      return showMap(context, viewModel);
    }
  }

  Widget showForm(context, viewModel){
    return Center(
      child: Padding(
          padding: EdgeInsets.only(left: 20, right: 20),
        child: FormBuilder(
          key: viewModel.formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const SizedBox(height: 20),
              FormBuilderTextField(
                keyboardType: TextInputType.text,
                name: 'name',
                style: const TextStyle(
                    color: Colors.black,
                    height: 2
                ),
                decoration: const InputDecoration(
                  labelText: 'Nombre de la geocerca',
                  floatingLabelBehavior: FloatingLabelBehavior.auto,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(30)),
                    borderSide: BorderSide.none,
                  ),
                  filled: true,
                  fillColor: Colors.white,
                  prefixIcon: Icon(
                    Icons.abc,
                    color: Colors.grey,
                  ),
                ),
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.required(
                    errorText: 'El campo no debe estar vacío',
                  )
                ]),
              ),
              FormBuilderTextField(
                keyboardType: TextInputType.text,
                name: 'description',
                style: const TextStyle(
                    color: Colors.black,
                    height: 2
                ),
                decoration: const InputDecoration(
                  labelText: 'Descripción de la geocerca',
                  floatingLabelBehavior: FloatingLabelBehavior.auto,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(30)),
                    borderSide: BorderSide.none,
                  ),
                  filled: true,
                  fillColor: Colors.white,
                  prefixIcon: Icon(
                    Icons.abc,
                    color: Colors.grey,
                  ),
                ),
                maxLines: 3,
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.required(
                    errorText: 'El campo no debe estar vacío',
                  )
                ]),
              ),
              DropDownMultiSelect(
                hintStyle: const TextStyle(
                    color: Colors.black,
                    height: 2
                ),
                decoration: const InputDecoration(
                  labelText: 'Vehiculos',
                  floatingLabelBehavior: FloatingLabelBehavior.auto,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(30)),
                    borderSide: BorderSide.none,
                  ),
                  filled: true,
                  fillColor: Colors.white,
                  prefixIcon: Icon(
                    Icons.abc,
                    color: Colors.grey,
                  ),
                ),
                onChanged: viewModel.setSelectedVehicles,
                selectedValues: viewModel.selectedVehicles,
                options: viewModel.vehicles,
              ),
              MaterialButton(
                color: const Color(0xFF6C18DB),
                textColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                height: 50,
                minWidth: double.infinity,
                onPressed: viewModel.createGeofences,
                child: const Text('Crear geocerca'),
              ),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }

  Widget showMap(context, viewModel) {
    final size = MediaQuery.of(context).size;
    return Stack(children: [
      // Mapa
      SizedBox(
        height: size.height * 0.795,
        child: FlutterMap(
          key: viewModel.mapKey,
          mapController: viewModel.mapController,
          options: MapOptions(
            initialCenter: viewModel.getVehicleCoordinates(),
            initialZoom: 14.0,
            onTap: (tapPosition, point) {
              switch (viewModel.mode) {
                case GeofenceMode.recommended:
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
      viewModel.canContinue()
          ? Positioned(
              bottom: size.height * 0.05,
              right: size.width * 0.355,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF18BEDB),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  padding: const EdgeInsets.symmetric(
                      horizontal: 32, vertical: 12),
                ),
                onPressed: () {
                  viewModel.setShowForm(true);
                  debugPrint("continuar: ${viewModel.getMarkerShape()}");
                },
                child: const Text("Continuar",
                    style: TextStyle(color: Colors.white)),
              )
            )
          : const SizedBox(width: 0.0, height: 0.0),
      if (viewModel.mode == GeofenceMode.circle)
        Positioned(
          bottom: size.height * 0.1,
          right: size.width * 0.3,
          child: Slider(
            secondaryActiveColor: Colors.white,
            thumbColor: Colors.red,
            value: viewModel.geofenceRadius,
            min: 1000,
            max: 7000,
            onChanged: viewModel.setGeofenceRadius,
          )
        )
    ]);
  }

  @override
  GeoFencesViewModel viewModelBuilder(BuildContext context) {
    return GeoFencesViewModel(context);
  }
}
