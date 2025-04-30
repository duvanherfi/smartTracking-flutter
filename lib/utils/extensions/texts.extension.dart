import 'package:flutter/material.dart';

extension TextExtensions on TextStyle {
  TextStyle get extraLight => copyWith(
        fontWeight: FontWeight.w200,
      );

  TextStyle get light => copyWith(
        fontWeight: FontWeight.w300,
      );

  TextStyle get regular => copyWith(
        fontWeight: FontWeight.w400,
      );

  TextStyle get medium => copyWith(
        fontWeight: FontWeight.w500,
      );

  TextStyle get semiBold => copyWith(
        fontWeight: FontWeight.w700,
      );

  TextStyle get bold => copyWith(
        fontWeight: FontWeight.w900,
      );

  TextStyle setColor(Color newColor) => copyWith(color: newColor);

  TextStyle setColorByTheme(Color onDark, Color onLight) =>
      copyWith(color: onLight);

  TextStyle setLightColor(Color newColor) => copyWith(
        color: newColor,
      );

  TextStyle setFontSize(double newFontSize) => copyWith(fontSize: newFontSize);

  TextStyle get underline =>
      copyWith(decoration: TextDecoration.underline, decorationColor: color);

  TextStyle get lineThrough =>
      copyWith(decoration: TextDecoration.lineThrough, decorationColor: color);

  TextStyle get italic => copyWith(fontStyle: FontStyle.italic);

  TextStyle get colorSecondaryText => setColor(const Color(0xFF18BEDB));

  TextStyle get colorAccent => setColor(Colors.white);
}
