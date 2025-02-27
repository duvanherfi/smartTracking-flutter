import 'package:stacked/stacked.dart';
import 'package:flutter/material.dart';

class AppBaseReactiveService with ReactiveServiceMixin{
  final ReactiveValue<bool> loadingReactiveValue = ReactiveValue(false);

  AppBaseReactiveService() {
    listenToReactiveValues([
      loadingReactiveValue,
    ]);
  }
}
