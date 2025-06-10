import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:smart_tracking/share/view_model/share_view_model.dart';
import 'package:smart_tracking/utils/app_component.dart';
import 'package:smart_tracking/widgets/splash_widget.dart';
import 'package:stacked/stacked.dart';

class ShareScreen extends StackedView<ShareViewModel> {
  const ShareScreen({super.key});

  @override
  Widget builder(BuildContext context, ShareViewModel viewModel, Widget? child) =>
      (viewModel.loading)
      ? const SplashWidget()
      : shareWidget(context, viewModel);

  @override
  ShareViewModel viewModelBuilder(BuildContext context) => ShareViewModel();

  Widget shareWidget(BuildContext context, ShareViewModel viewModel) {
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
                alignment: Alignment.center,
                color: Colors.transparent,
                margin: EdgeInsets.only(top: size.height * 0.25),
                child: Center(
                  child: Column(
                    children: [
                      const Text(
                        "Opciones para compartir la",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Text(
                        "ubicación de tu dispositivo",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Color(0xFF6c18db),
                          backgroundColor: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 30),
                      MaterialButton(
                        onPressed: viewModel.openMap,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            IconButton(
                              onPressed: viewModel.openMap,
                              icon: const ImageIcon(
                                AssetImage('assets/images/waze.png'),
                                color: Color(0xFF6c18db),
                                size: 60,
                              ),
                              style: ButtonStyle(
                                backgroundColor: WidgetStateColor.resolveWith(
                                  (states) => Colors.white,
                                ),
                              ),
                            ),
                            const SizedBox(width: 10),
                            const Text(
                                "Via waze o Google Maps",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                )
                            )
                          ],
                        ),
                      ),
                      const SizedBox(height: 30),
                      MaterialButton(
                        onPressed: viewModel.openExternalLink,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            IconButton(
                              onPressed: viewModel.openExternalLink,
                              icon: const ImageIcon(
                                AssetImage('assets/images/maps.png'),
                                color: Color(0xFF6c18db),
                                size: 60,
                              ),
                              style: ButtonStyle(
                                backgroundColor: WidgetStateColor.resolveWith(
                                  (states) => Colors.white,
                                ),
                              ),
                            ),
                            const SizedBox(width: 10),
                            const Text(
                                "Link externo a Google maps",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                )
                            )
                          ],
                        ),
                      ),

                    ],
                  )
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
