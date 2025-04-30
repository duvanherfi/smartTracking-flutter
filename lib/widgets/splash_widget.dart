import 'package:flutter/material.dart';
import 'package:smart_tracking/widgets/loading.dart';

class SplashWidget extends StatefulWidget {
  const SplashWidget({super.key});

  @override
  SplashWidgetState createState() => SplashWidgetState();
}

class SplashWidgetState extends State<SplashWidget> {
  @override
  Widget build(BuildContext context) => Container(
        width: context.width,
        height: context.height,
        color: Theme.of(context).colorScheme.surface,
        child: const Loading(),
      );
}

extension on BuildContext {
  get width => null;

  get height => null;
}
