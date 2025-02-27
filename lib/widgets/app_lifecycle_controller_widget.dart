import 'package:flutter/material.dart';

class AppLifeCycleControllerWidget extends StatefulWidget {
  final Function(AppLifecycleState) onDidChangeAppLifecycleState;
  final Widget child;

  const AppLifeCycleControllerWidget({
    super.key,
    required this.onDidChangeAppLifecycleState,
    required this.child,
  });

  @override
  State<AppLifeCycleControllerWidget> createState() =>
      _AppLifeCycleControllerWidgetState();
}

class _AppLifeCycleControllerWidgetState
    extends State<AppLifeCycleControllerWidget> with WidgetsBindingObserver {
  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    widget.onDidChangeAppLifecycleState.call(state);
  }

  @override
  Widget build(BuildContext context) => widget.child;

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }
}
