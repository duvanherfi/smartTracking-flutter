import 'package:flutter/material.dart';
import 'package:smart_tracking/base/screen/base_screen.dart';
import 'package:smart_tracking/widgets/home_widget.dart';
import 'package:smart_tracking/widgets/splash_widget.dart';
import 'package:smart_tracking/home/view_model/home_view_model.dart';
import 'package:stacked/stacked.dart';
import 'package:smart_tracking/widgets/app_lifecycle_controller_widget.dart';

class HomeScreen extends StackedView<HomeViewModel> {
  const HomeScreen({super.key});

  static var chilKey = UniqueKey();

  @override
  Widget builder(
    BuildContext context,
    HomeViewModel viewModel,
    Widget? child,
  ) =>
      AppLifeCycleControllerWidget(
        onDidChangeAppLifecycleState: (appLifeCycleState) {},
        child: (viewModel.loading)
            ? const SplashWidget()
            : ViewModelBuilder<HomeViewModel>.reactive(
                viewModelBuilder: () => HomeViewModel(context),
                builder: (context, homeViewModel, child) => BaseScreen(
                    topSafeArea: false,
                    statusBarColor: null
                ),
              ),
      );

  @override
  HomeViewModel viewModelBuilder(BuildContext context) =>
      HomeViewModel(context);
}
