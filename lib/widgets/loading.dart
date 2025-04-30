import 'package:flutter/material.dart';
class Loading extends StatefulWidget {
  final Widget? progress;
  final Color? backgroundColor;

  const Loading({super.key, this.progress, this.backgroundColor});

  @override
  _LoadingState createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  @override
  Widget build(BuildContext context) => Container(
        width: double.maxFinite,
        height: double.maxFinite,
        color: widget.backgroundColor ??
            Theme.of(context).colorScheme.surface.withOpacity(.3),
        child: Center(
          child: widget.progress != null
              ? SizedBox(height: 100, width: 100, child: widget.progress)
              : SizedBox(
                  height: 100,
                  width: 100,
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(
                      Theme.of(context).colorScheme.primary,
                    ),
                ),
              )
        ),
      );
}
