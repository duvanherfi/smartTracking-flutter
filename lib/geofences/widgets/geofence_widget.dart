import 'package:flutter/material.dart';
import 'package:smart_tracking/api/model/geo_fence.dart';
import 'package:smart_tracking/base/view_model/base_screen_view_model.dart';
import 'package:smart_tracking/routes.dart';
import 'package:smart_tracking/utils/app_component.dart';
import 'package:smart_tracking/widgets/geo_fence_card.dart';
import 'package:stacked/stacked.dart';

class GeofenceWidget extends ViewModelWidget<BaseScreenViewModel> {
  const GeofenceWidget({super.key});


  @override
  Widget build(BuildContext context, BaseScreenViewModel viewModel) {
    return viewModel.geoFences.isNotEmpty
        ? SizedBox(
            child: Padding(
                padding: const EdgeInsets.only(bottom: 3, top: 3),
              child: ListView.builder(
                itemCount: viewModel.geoFences.length,
                controller: ScrollController(),
                shrinkWrap: true,
                itemBuilder: (_, index) {
                  return GestureDetector(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (_) => geoFenceAction(
                            context, viewModel, viewModel.geoFences[index]
                        ),
                      );
                    },
                    child: GeoFenceCard(
                        geoFence: viewModel.geoFences[index]
                    ),
                  );
                },
              ),
            ),
          )
        : const Center(
            child: Text(
              'No hay geocercas disponibles',
              style: TextStyle(fontSize: 20),
            ),
          );
  }

  Widget geoFenceAction(BuildContext context, BaseScreenViewModel viewModel, GeoFence geoFence){
    return AlertDialog(
      title: const Text(
          "Atención",
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Color(0xFF6c18db),
          fontSize: 25
        ),
      ),

      content: SizedBox(
        height: 200,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            MaterialButton(
              onPressed: (){
                viewModel.setGeoFence(geoFence);
                appNavigator.push(Routes.addGeoFence);
              },
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.edit, size: 30, color: Color(0xFF6c18db),),
                  SizedBox(width: 10),
                  Text("Editar", style: TextStyle(fontSize: 25, color: Color(0xFF6c18db))),
                ],
              ),
            ),
            MaterialButton(
              onPressed: (){},
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.delete, size: 30, color: Colors.red,),
                  SizedBox(width: 10),
                  Text("Eliminar", style: TextStyle(fontSize: 25, color: Colors.red)),
                ],
              ),
            ),
            MaterialButton(
              onPressed: (){
                appNavigator.back();
              },
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.cancel_outlined, size: 30, color: Colors.black87),
                  SizedBox(width: 10),
                  Text("Cancelar", style: TextStyle(fontSize: 25, color: Colors.black87)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
