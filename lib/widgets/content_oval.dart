import 'package:flutter/material.dart';

class ContentOval extends StatelessWidget {
  final double width;
  final double height;
  final Color backgroudnColor;
  final Color boderBackgroudnColor;
  final Widget child;
  final double firtsBorderWidth;
  final Color firtsBorderColor;
  final double secondBorderWidth;
  final Color secondBorderColor;
  static const Color cianColor = Color(0xFF18BEDB);

  const ContentOval({
    required this.width,
    required this.height,
    required this.child,
    this.backgroudnColor = Colors.white,
    this.boderBackgroudnColor = Colors.white,
    this.firtsBorderWidth = 10,
    this.secondBorderWidth = 10,
    this.firtsBorderColor = Colors.white,
    this.secondBorderColor = cianColor,
  });

  @override
  Widget build(BuildContext context) =>
      ClipOval(
        child: Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
            color: backgroudnColor,
            borderRadius: BorderRadius.circular(width),
            border: firtsBorderWidth > 0.0 ? Border.all(
              color: firtsBorderColor,
              width: firtsBorderWidth,
            ) : null,
          ),
          child: Container(
            width: width,
            height: height,
            decoration: BoxDecoration(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(width),
              border: secondBorderWidth > 0.0 ? Border.all(
                color: secondBorderColor,
                width: secondBorderWidth,
              ) : null,
            ),
            child: Center(
                child: child
            ),
          ),
        ),
      );
}