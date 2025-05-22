import 'package:flutter/material.dart';
import 'package:smart_tracking/base/screen/base_screen.dart';
import 'package:smart_tracking/home/view_model/home_view_model.dart';
import 'package:smart_tracking/widgets/splash_widget.dart';
import 'package:stacked/stacked.dart';

class HomeScreen extends StackedView<HomeViewModel> {
  const HomeScreen({super.key});

  @override
  Widget builder(BuildContext context, HomeViewModel viewModel, Widget? child) {
    return (viewModel.loading)
        ? const SplashWidget()
        : ViewModelBuilder<HomeViewModel>.reactive(
      viewModelBuilder: () => HomeViewModel(context),
      builder: (context, homeViewModel, child) => BaseScreen(
          topSafeArea: false,
          statusBarColor: null
      ),
    );
}

  @override
  HomeViewModel viewModelBuilder(BuildContext context) =>
      HomeViewModel(context);
}
