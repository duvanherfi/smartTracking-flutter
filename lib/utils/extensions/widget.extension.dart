import 'package:flutter/material.dart';

/// Widget Extension
///
/// * https://blog.stackademic.com/flutter-extensions-tricks-to-boost-your-productivity-88573b7efc0f
extension WidgetExtension on Widget {
  Expanded expanded({int flex = 1}) => Expanded(
        flex: flex,
        child: this,
      );

  Flexible flexible({int flex = 1}) => Flexible(
        flex: flex,
        child: this,
      );

  Opacity setOpacity(double val) => Opacity(
        opacity: val,
        child: this,
      );

  Padding withPadding(EdgeInsets padding) => Padding(
        padding: padding,
        child: this,
      );

  SizedBox box({double? width, double? height}) =>
      SizedBox(width: width, height: height, child: this);

  Center center() => Center(
        child: this,
      );

  ClipRRect clipRRect(double radius) => ClipRRect(
        borderRadius: BorderRadius.circular(radius),
        child: this,
      );

  Widget toScroll({
    bool alwaysActiveScroll = true,
    EdgeInsets? padding,
    ScrollPhysics? physics,
    Axis axis = Axis.vertical,
    ScrollController? controller,
  }) =>
      alwaysActiveScroll
          ? SingleChildScrollView(
              physics: physics,
              padding: padding,
              scrollDirection: axis,
              controller: controller,
              child: this,
            )
          : this;

  Widget onClick(void Function()? onClick) => GestureDetector(
        onTap: onClick?.call,
        child: this,
      );

  RotatedBox rotate(int quarterTurns) => RotatedBox(
        quarterTurns: quarterTurns,
        child: this,
      );

  Widget withScrollbar({
    bool showScrollBarAlways = true,
    ScrollController? controller,
  }) =>
      Scrollbar(
        thumbVisibility: showScrollBarAlways,
        trackVisibility: showScrollBarAlways,
        controller: controller,
        child: this,
      );

  DecoratedBox withDecoratedBox(Decoration decoration) =>
      DecoratedBox(decoration: decoration, child: this);
}
