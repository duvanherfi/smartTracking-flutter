import 'package:flutter/material.dart';

Widget disableGlow(Widget child) =>
    NotificationListener<OverscrollIndicatorNotification>(
        onNotification: (overscroll) {
          overscroll.disallowIndicator();
          return true;
        },
        child: child);
