import 'package:flutter/material.dart';
import 'package:smart_tracking/services/home_services.dart';
import 'package:smart_tracking/utils/app_component.dart';

class HeaderDrawerWidget extends StatefulWidget {
  final bool isRooted;
  final bool isRealDevice;

  HeaderDrawerWidget(
    this.isRooted,
    this.isRealDevice, {
    super.key,
  });

  @override
  State<HeaderDrawerWidget> createState() => _HeaderDrawerWidgetState();
}

class _HeaderDrawerWidgetState extends State<HeaderDrawerWidget> {
  final _homeServices = locator<HomeServices>();

  @override
  void initState() {
    super.initState();
  }

  Widget avatar() =>
      Stack(
        clipBehavior: Clip.none,
        children: [
          CircleAvatar(
              backgroundColor: Colors.transparent,
              radius: 50,
              child: Image.asset(
                'assets/images/user.png',
                width: 70,
                height: 70,
              )
          ),
        ],
      );

  Widget name() {

    return Text(
      _homeServices.user.value?.name ?? "Usuario",
      maxLines: 2,
      style: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: Colors.black,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          margin: const EdgeInsets.only(bottom: 8.0),
          padding: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: Color(0xFF18BEDB),
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(40),
                bottomRight: Radius.circular(40)
            ),
          ),
          child: Column(
            children: [
              Row(
                children: [
                  avatar(),
                  Flexible(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        name(),
                      ],
                    ),
                  ),
                ],
              ),
              if (widget.isRooted || !widget.isRealDevice)
                Container(
                  margin: const EdgeInsets.only(
                    top: 10,
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: Text(
                    "Télefono rooteado o emulador",
                    maxLines: 3,
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.red,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }
}
