import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:smart_tracking/api/model/geo_fence.dart';
import 'package:smart_tracking/api/model/user_notification.dart';
import 'package:smart_tracking/base/view_model/base_screen_view_model.dart';
import 'package:smart_tracking/user_notifications/view_model/user_notification_view_model.dart';
import 'package:stacked/stacked.dart';
import 'package:url_launcher/url_launcher.dart';

class UserNotificationCard extends ViewModelWidget<UserNotificationViewModel> {
  final UserNotification userNotification;
  static double width = 340;
  static double height = 200;


  const UserNotificationCard({
    super.key, required this.userNotification
  });

  @override
  Widget build(BuildContext context, UserNotificationViewModel viewModel) {
    LatLng point = LatLng(userNotification.lat ?? 0, userNotification.lon ?? 0);
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
                Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF1942DB),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(Radius.circular(width / 2)),
                              ),
                            ),
                            onPressed: (){},
                            child: Text(
                              userNotification.type ?? 'Notificación',
                              style: const TextStyle(
                                  color: Colors.white
                              ),
                            )
                        ),
                        Text(
                          '${userNotification.plates} reporta ${userNotification.translate} ${userNotification.geoFence}\n cerca de ${userNotification.labelDirection}',
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
                    )
                ),
                Expanded(
                    child: FlutterMap(
                      options: MapOptions(
                        interactionOptions: const InteractionOptions(
                            flags: InteractiveFlag.none
                        ),
                        initialCenter: point,
                        initialZoom: 15,
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
                        MarkerLayer(
                            markers: [
                              Marker(
                                  point: point,
                                  child: const Icon(
                                      Icons.location_on,
                                      size: 50,
                                      color: Colors.red
                                  )
                              )
                            ]
                        )
                      ],
                    )
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}