import 'package:flutter/material.dart';
import 'package:smart_tracking/base/view_model/base_screen_view_model.dart';
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
                      viewModel.geoFenceAction(
                          context, viewModel.geoFences[index]
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
}
