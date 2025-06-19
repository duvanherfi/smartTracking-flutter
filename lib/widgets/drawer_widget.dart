import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:smart_tracking/routes.dart';
import 'package:smart_tracking/utils/app_component.dart';
import 'package:smart_tracking/utils/extensions/widget.extension.dart';
import 'package:smart_tracking/widgets/header_drawer_widget.dart';

class DrawerWidget extends StatefulWidget {
  final Function(String) onTap;

  const DrawerWidget(
    this.onTap,
    {
    super.key,
  });

  @override
  DrawerWidgetState createState() => DrawerWidgetState();
}

class DrawerWidgetState extends State<DrawerWidget> {
  final scrollController = ScrollController();
  bool showLegalOptions = false;
  bool isRooted = false;
  bool isRealDevice = true;
  PackageInfo _packageInfo = PackageInfo(
    version: 'Unknown',
    appName: '',
    buildNumber: '',
    packageName: '',
  );

  void _initPackageInfo() async {
    _packageInfo = await PackageInfo.fromPlatform();
    setState(() {});
  }



  Widget _createItemsDrawer() {
    List<Widget> drawerItem = [];
    drawerItem.add(
      _builderItemDrawer(
          "Inicio",
          const Icon(Icons.home, color: Color(0xFF6C18DB), size: 50),
          'home'
      ),
    );
    drawerItem.add(
      _builderItemDrawer(
          "Datos de usuario",
          const Icon(Icons.tune, color: Color(0xFF6C18DB), size: 50),
          'user'
      ),
    );
    drawerItem.add(
      _builderItemDrawer(
          "Politicas de seguridad",
          const Icon(Icons.receipt_long, color: Color(0xFF6C18DB), size: 50),
          'politics'
      ),
    );
    drawerItem.add(
      _builderItemDrawer(
          "Configuración de alertas",
          const Icon(Icons.warning, color: Color(0xFF6C18DB), size: 50),
          'notifications'
      ),
    );

    return Column(children: drawerItem);
  }

  Widget _createFooterDrawer() => Align(
    alignment: FractionalOffset.bottomCenter,
    child: Column(
      children: [
        TextButton(
          style: ButtonStyle(
            backgroundColor: WidgetStateProperty.all(const Color(0xFF6C18DB)),
          ),
          onPressed: () async {
            await sharedPreferencesV2.clearData();
            appNavigator.pushReplacement(Routes.login);
          },
          child: const Text(
            'Cerrar sesión',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.w500
            ),
          ),
        ),
        versionApp(),
        SizedBox(height: 30),
      ]
    ),
  );



  ListTile _builderItemDrawer(String content, Widget icon, String id,
      {int count = 0, Widget? trailingIcon}) {
    return ListTile(
      onTap: () => widget.onTap(id),
      title: Text(
          content, maxLines: 2,
          style: TextStyle(
              color: Color(0xFF6C18DB),
              fontSize: 20,
              fontWeight: FontWeight.w500
          )
      ),
      leading: icon.withPadding(const EdgeInsets.only(left: 7)),
      trailing: trailingIcon ??
          Visibility(
            visible: count > 0,
            child: Container(
              height: 24,
              width: 24,
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(100),
              ),
              child: Center(
                child: Text(
                  count == 0 || count >= 10 ? '' : count.toString(),
                ),
              ),
            ),
          ),
    );
  }

  Widget versionApp() => Text(
    _packageInfo.version,
    style: TextStyle(
      fontSize: 12,
      color: Colors.black,
    ),
  );


  @override
  void initState() {
    super.initState();
    _initPackageInfo();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      elevation: 0,
      child: ColoredBox(
        color: Theme.of(context).colorScheme.surface,
        child: Column(
          children: [
            Expanded(
              child: ListView(
                controller: scrollController,
                children: [
                  HeaderDrawerWidget(
                    isRooted,
                    isRealDevice,
                  ),
                  _createItemsDrawer()
                ],
              ),
            ),
            _createFooterDrawer()
          ],
        ),
      ),
    );
  }
}
