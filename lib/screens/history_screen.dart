import 'package:flutter/material.dart';
import 'package:smart_tracking/screens/base_screen.dart';
import 'package:smart_tracking/widgets/splash_widget.dart';
import 'package:stacked/stacked.dart';
import 'package:smart_tracking/widgets/app_lifecycle_controller_widget.dart';

import '../history/view_model/history_view_model.dart';

class HistoryScreen extends StackedView<HistoryViewModel> {
  const HistoryScreen({super.key});

  @override
  Widget builder(
      BuildContext context,
      HistoryViewModel viewModel,
      Widget? child,
      ) =>
      AppLifeCycleControllerWidget(
        onDidChangeAppLifecycleState: (AppLifecycleState ) {},
        child: (viewModel.loading) ? const SplashWidget()
            : ViewModelBuilder<HistoryViewModel>.reactive(
          viewModelBuilder: () => HistoryViewModel(context),
          builder: (context, historyViewModel, child) =>
              BaseScreen(
                scaffoldKey: historyViewModel.scaffoldKey,
                topSafeArea: false,
                statusBarColor: null,
                body: Placeholder()
              ),
        ),
      );

  @override
  HistoryViewModel viewModelBuilder(BuildContext context) =>
      HistoryViewModel(context);
}
