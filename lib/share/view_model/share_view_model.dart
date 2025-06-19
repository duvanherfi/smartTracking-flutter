

import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_svg/svg.dart';
import 'package:smart_tracking/services/home_services.dart';
import 'package:smart_tracking/utils/app_base_view_model.dart';
import 'package:smart_tracking/utils/app_component.dart';
import 'package:map_launcher/map_launcher.dart';
import 'package:smart_tracking/utils/extensions/dialog.extension.dart';
import 'package:url_launcher/url_launcher.dart';

class ShareViewModel extends AppBaseViewModel {
  final _homeServices = locator<HomeServices>();
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
  final formKey = GlobalKey<FormBuilderState>();
  bool loading = false;

  get vehicle => _homeServices.vehicle.value;

  void openMap() async {
    final coords = Coords(double.parse(vehicle.lat), double.parse(vehicle.lon));
    final availableMaps = await MapLauncher.installedMaps;
    if (availableMaps.isNotEmpty) {

      showModalBottomSheet(
        context: scaffoldKey.currentContext!,
        builder: (BuildContext context) {
          return SafeArea(
            child: SingleChildScrollView(
              child: Container(
                child: Wrap(
                  children: <Widget>[
                    for (var map in availableMaps)
                      ListTile(
                        onTap: () => map.showMarker(
                          coords: coords,
                          title: vehicle.plates,
                        ),
                        title: Text(map.mapName),
                        leading: SvgPicture.asset(
                          map.icon,
                          height: 30.0,
                          width: 30.0,
                        ),
                      ),
                  ],
                ),
              ),
            ),
          );
        },
      );
    } else {
      showPiDialog('No maps available');
    }
  }

  void openExternalLink() {
    final url = "https://maps.google.com/?q=${vehicle.lat},${vehicle.lon}";
    launchUrl(Uri.parse(url));
  }

}