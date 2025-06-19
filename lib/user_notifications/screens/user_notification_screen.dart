import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:smart_tracking/api/model/vehicle.dart';
import 'package:smart_tracking/user_notifications/view_model/user_notification_view_model.dart';
import 'package:smart_tracking/user_notifications/widgets/user_notification_card.dart';
import 'package:smart_tracking/utils/app_component.dart';
import 'package:smart_tracking/widgets/splash_widget.dart';
import 'package:stacked/stacked.dart';

class UserNotificationScreen extends StackedView<UserNotificationViewModel> {
  const UserNotificationScreen({super.key});

  @override
  Widget builder(BuildContext context, UserNotificationViewModel viewModel, Widget? child) {
    final size = MediaQuery.of(context).size;
    return Container(
      color: Colors.white,
      child: AnnotatedRegion<SystemUiOverlayStyle>(
        value: const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          systemNavigationBarColor: Colors.white,
          statusBarBrightness: Brightness.light,
          statusBarIconBrightness: Brightness.light,
          systemNavigationBarIconBrightness: Brightness.light,
        ),
        child: Stack(
          children: [
            SafeArea(
              top: false,
              child: Scaffold(
                key: viewModel.scaffoldKey,
                resizeToAvoidBottomInset: false,
                extendBody: false,
                backgroundColor: Colors.white,
                body: viewModel.loading ? const SplashWidget() :
                Container(
                  width: size.width,
                  height: size.height,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/images/background.png'),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Container(
                    width: size.width,
                    height: size.height,
                    decoration: BoxDecoration(
                      color: const Color(0xFF18BEDB).withOpacity(0.88),
                    ),
                    child: Stack(
                      alignment: Alignment.centerLeft,
                      children: [
                        Container(
                          width: size.width,
                          height: size.height,
                          padding: const EdgeInsets.only(
                            top: 50,
                          ),
                          child: viewModel.userNotifications.isNotEmpty
                              ? SizedBox(
                            child: Padding(
                              padding: const EdgeInsets.only(bottom: 3, top: 1),
                              child: ListView.builder(
                                itemCount: viewModel.userNotifications.length,
                                controller: ScrollController(),
                                shrinkWrap: true,
                                itemBuilder: (_, index) {
                                  return GestureDetector(
                                    onTap: () {
                                      viewModel.userNotificationAction(
                                          context, viewModel.userNotifications[index]
                                      );
                                    },
                                    child: UserNotificationCard(
                                        userNotification: viewModel.userNotifications[index]
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
                          ),
                        ),
                        Positioned(
                            top: 30,
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  const Padding(
                                      padding:
                                      EdgeInsets.only(left: 2)
                                  ),
                                  IconButton(
                                      style: ButtonStyle(
                                          backgroundColor:
                                          WidgetStateColor.resolveWith((states) => Colors.white)
                                      ),
                                      onPressed: () => appNavigator.back(),
                                      icon: const Icon(
                                          Icons.arrow_back,
                                          color: Color(0xFF6c18db),
                                          size: 30
                                      )
                                  ),
                                  const Padding(
                                      padding:
                                      EdgeInsets.symmetric(horizontal: 50)
                                  ),

                                  DropdownButton(
                                    padding: EdgeInsets.all(0),
                                    style: const TextStyle(
                                      color: Color(0xFF6c18db),
                                      backgroundColor: Colors.white,
                                      fontSize: 20,
                                    ),
                                    dropdownColor: Colors.white,
                                    borderRadius: BorderRadius.circular(10),
                                    value: viewModel.vehicleId,
                                    items: viewModel.vehicles.map((Vehicle vehicle) {
                                      return DropdownMenuItem<String>(
                                        value: vehicle.id,
                                        child: Text(vehicle.toString()),
                                      );
                                    }).toList(),
                                    onChanged: viewModel.onVehicleTap,
                                    icon: const Icon(Icons.keyboard_arrow_down,
                                        color: Color(0xFF6c18db), size: 45),
                                    menuMaxHeight: 200,
                                  ),
                                  const Padding(
                                      padding:
                                      EdgeInsets.symmetric(horizontal: 40)
                                  ),
                                ])),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  UserNotificationViewModel viewModelBuilder(BuildContext context) {
    return UserNotificationViewModel(context);
  }
}
