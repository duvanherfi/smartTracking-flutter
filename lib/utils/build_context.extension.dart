import 'package:flutter/material.dart';

extension BuildContextExtension on BuildContext {
  double get height => MediaQuery.sizeOf(this).height;

  double get width => MediaQuery.sizeOf(this).width;

  double get aspectRatio => MediaQuery.sizeOf(this).aspectRatio;

  double get longestSide => MediaQuery.sizeOf(this).longestSide;

  double get shortestSide => MediaQuery.sizeOf(this).shortestSide;

  EdgeInsets get viewPadding => MediaQuery.viewPaddingOf(this);

  EdgeInsets get viewInsets => MediaQuery.viewInsetsOf(this);

  void get openDrawer => Scaffold.of(this).openDrawer();

  void get closeDrawer => Scaffold.of(this).closeDrawer();

  void get unFocus => FocusManager.instance.primaryFocus?.unfocus();

  dynamic requestFocus(FocusNode focusNode) =>
      FocusScope.of(this).requestFocus(focusNode);

  TextStyle? get displayLarge => Theme.of(this).textTheme.displayLarge;

  TextStyle? get displayMedium => Theme.of(this).textTheme.displayMedium;

  TextStyle? get displaySmall => Theme.of(this).textTheme.displaySmall;

  TextStyle? get headlineLarge => Theme.of(this).textTheme.headlineLarge;

  TextStyle? get headlineMedium => Theme.of(this).textTheme.headlineMedium;

  TextStyle? get headlineSmall => Theme.of(this).textTheme.headlineSmall;

  TextStyle? get titleLarge => Theme.of(this).textTheme.titleLarge;

  TextStyle? get titleMedium => Theme.of(this).textTheme.titleMedium;

  TextStyle? get titleSmall => Theme.of(this).textTheme.titleSmall;

  TextStyle? get bodyLarge => Theme.of(this).textTheme.bodyLarge;

  TextStyle? get bodyMedium => Theme.of(this).textTheme.bodyMedium;

  TextStyle? get bodySmall => Theme.of(this).textTheme.bodySmall;

  TextStyle? get labelLarge => Theme.of(this).textTheme.labelLarge;

  TextStyle? get labelMedium => Theme.of(this).textTheme.labelMedium;

  TextStyle? get labelSmall => Theme.of(this).textTheme.labelSmall;

  ColorScheme get currentTheme => Theme.of(this).colorScheme;
}
