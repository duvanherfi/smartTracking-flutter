import 'package:stacked/stacked.dart';

class AppBaseReactiveService with ListenableServiceMixin{
  final ReactiveValue<bool> loadingReactiveValue = ReactiveValue(false);

  AppBaseReactiveService() {
    listenToReactiveValues([
      loadingReactiveValue,
    ]);
  }
}
