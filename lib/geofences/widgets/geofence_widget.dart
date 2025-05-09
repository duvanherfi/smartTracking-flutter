import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:smart_tracking/widgets/geo_fence_card.dart';
import 'package:stacked/stacked.dart';
import 'package:smart_tracking/base/view_model/base_view_model.dart';
import 'package:smart_tracking/widgets/content_oval.dart';
import 'package:url_launcher/url_launcher.dart';

class GeofenceWidget extends ViewModelWidget<BaseScreenViewModel> {
  const GeofenceWidget({super.key});


  @override
  Widget build(BuildContext context, BaseScreenViewModel viewModel) {
    return viewModel.geoFences.length > 0
        ? SizedBox(
            child: Padding(
                padding: const EdgeInsets.only(bottom: 3, top: 3),
              child: ListView.builder(
                itemCount: viewModel.geoFences.length,
                controller: ScrollController(),
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return GeoFenceCard(geoFence: viewModel.geoFences[index]);
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
