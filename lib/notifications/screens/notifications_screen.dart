import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:smart_tracking/notifications/view_model/notifications_view_model.dart';
import 'package:smart_tracking/utils/app_component.dart';
import 'package:smart_tracking/widgets/loading.dart';
import 'package:smart_tracking/widgets/splash_widget.dart';
import 'package:stacked/stacked.dart';

class NotificationScreen extends StackedView<NotificationsViewModel> {
  const NotificationScreen({super.key});

  @override
  Widget builder(BuildContext context, NotificationsViewModel viewModel, Widget? child) =>
      (viewModel.loading)
      ? const SplashWidget()
      : shareWidget(context, viewModel);

  @override
  NotificationsViewModel viewModelBuilder(BuildContext context) => NotificationsViewModel();

  Widget shareWidget(BuildContext context, NotificationsViewModel viewModel) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      key: viewModel.scaffoldKey,
      resizeToAvoidBottomInset: false,
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/background.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Container(
          decoration: BoxDecoration(
            color: const Color(0xFF18BEDB).withOpacity(0.88),
          ),
          child: Stack(
            alignment: Alignment.center,
            children: [
              Positioned(
                  top: -200,
                  child: Container(
                    width: size.width,
                    height: size.height * 0.4,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/images/header.png'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  )
              ),
              Positioned(
                  top: size.height * 0.05,
                  child: const Image(
                    image: AssetImage('assets/images/icon.png'),
                  )
              ),
              Positioned(
                  top: size.height * 0.05,
                  left: size.width * 0.05,
                  child: IconButton(
                      style: ButtonStyle(
                          backgroundColor:
                          WidgetStateColor.resolveWith((states) => Colors.white)),
                      onPressed: () => appNavigator.back(),
                      icon: const Icon(Icons.arrow_back,
                          color: Color(0xFF6c18db), size: 30)
                  ),
              ),
              Container(
                height: size.height,
                width: size.width,
                alignment: Alignment.center,
                color: Colors.transparent,
                margin: EdgeInsets.only(top: size.height * 0.20),
                padding: EdgeInsetsDirectional.symmetric(horizontal: size.width * 0.05),
                child: viewModel.notifications.isNotEmpty ?
                  notifications(size, context, viewModel)
                  : Center(
                      child: Text(
                        'No hay geocercas disponibles',
                        style: TextStyle(fontSize: 20),
                      ),
                  ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget notifications(Size size, BuildContext context, NotificationsViewModel viewModel) {
    return Center(
      child: Padding(
          padding: const EdgeInsets.only(bottom: 40),
        child: Column(
          children: [
            Expanded(
                child: ListView.builder(
                  itemCount: viewModel.notifications.length,
                  controller: ScrollController(),
                  itemBuilder: (_, index) {
                    return FormBuilderSwitch(
                      name: "is_enabled",
                      activeTrackColor: Color(0xFF6c18db),
                      inactiveThumbColor: Colors.white,
                      inactiveTrackColor: Colors.grey,
                      initialValue: viewModel.notifications[index].isEnabled!,
                      onChanged: (value) {
                        viewModel.updateNotification(
                            viewModel.notifications[index],
                            index
                        );
                      },
                      title: Text(
                          viewModel.indexLoading == index
                              ? 'Cargando...'
                              :
                          viewModel.notifications[index].name ?? '',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          )
                      ),
                      decoration: InputDecoration(
                        border: InputBorder.none,
                      ),
                    );
                  },
                )
            ),
          ],
        ),
      ),
    );
  }
}
