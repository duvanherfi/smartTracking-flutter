import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:smart_tracking/api/model/trip.dart';
import 'package:smart_tracking/base/view_model/base_screen_view_model.dart';
import 'package:smart_tracking/user_notifications/view_model/user_notification_view_model.dart';
import 'package:stacked/stacked.dart';
import 'package:url_launcher/url_launcher.dart';

class TripCard extends ViewModelWidget<BaseScreenViewModel> {
  final Trip trip;
  static double width = 340;
  static double height = 200;


  const TripCard({
    super.key, required this.trip
  });

  @override
  Widget build(BuildContext context, BaseScreenViewModel viewModel) {
    return Padding(
      padding: EdgeInsets.only(bottom: 5),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            height: height,
            width: width,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                  color: const Color(0xFF1942DB),
                  width: 2
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'Distancia\n ${trip.distance ?? 0 / 1000} km',
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                          softWrap: true,
                          maxLines: 7,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const Divider(height: 1, thickness: 1, indent: 10, endIndent: 10, color: Colors.black),
                        Text(
                          'Tiempo\n ${((trip.duration ?? 0) / 60000).toStringAsPrecision(2)} min',
                          style: const TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                          softWrap: true,
                          maxLines: 7,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    )
                ),
                Expanded(
                    child: viewModel.getTripMap(trip, true)
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}