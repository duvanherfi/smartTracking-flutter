import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:smart_tracking/api/model/geo_fence.dart';
import 'package:smart_tracking/base/view_model/base_screen_view_model.dart';
import 'package:stacked/stacked.dart';
import 'package:url_launcher/url_launcher.dart';

class GeoFenceCard extends ViewModelWidget<BaseScreenViewModel> {
  final GeoFence geoFence;
  static double width = 340;
  static double height = 200;


  const GeoFenceCard({
    super.key, required this.geoFence
  });

  @override
  Widget build(BuildContext context, BaseScreenViewModel viewModel) {
    List<LatLng> coordinates = geoFence.areaGeojson!.coordinates.first
        .map((points) => LatLng(points[1], points[0]))
        .toList();
    return Padding(
      padding: EdgeInsets.only(bottom: 5),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            height: height,
            width: width,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                  color: const Color(0xFF1942DB),
                  width: 2
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  height: height / 2,
                  width: width / 2,
                  child:  Column(
                    spacing: 10,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF1942DB),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                          onPressed: ()=>Null,
                          child: const Text(
                            "Geocerca",
                            style: TextStyle(
                                color: Colors.white
                            ),
                          )
                      ),
                      Text(
                        '${geoFence.name} creada cerca de ${geoFence.labelDirection}',
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                        softWrap: true,
                        maxLines: 7,
                        overflow: TextOverflow.ellipsis,
                      )
                    ],
                  ),
                ),
                SizedBox(
                  width: width / 2 - 10,
                  height: height,
                  child: FlutterMap(
                    options: MapOptions(
                      interactionOptions: const InteractionOptions(
                        flags: InteractiveFlag.none
                      ),
                      onTap: (_, __) {
                        viewModel.geoFenceAction(
                            context, geoFence
                        );
                      },
                      initialCenter: LatLng.fromJson(
                          geoFence.centroidGeojson!.toJson()
                      ),
                      initialZoom: 11,
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
                      PolygonLayer(
                        polygons: [
                          Polygon(
                            points: coordinates,
                            borderStrokeWidth: 3,
                            borderColor: Colors.blueAccent,
                          ),
                        ],
                      )
                    ],
                  ),
                )

              ],
            ),
          )
        ],
      ),
    );
  }
}