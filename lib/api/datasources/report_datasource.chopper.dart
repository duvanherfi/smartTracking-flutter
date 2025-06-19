// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'report_datasource.dart';

// **************************************************************************
// ChopperGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
final class _$ReportDataSource extends ReportDataSource {
  _$ReportDataSource([ChopperClient? client]) {
    if (client == null) return;
    this.client = client;
  }

  @override
  final Type definitionType = ReportDataSource;

  @override
  Future<Response<List<Trip>>> getTravels(
    String vehicleId,
    String from,
    String to,
  ) {
    final Uri $url = Uri.parse('/reports/trips');
    final Map<String, dynamic> $params = <String, dynamic>{
      'vehicle_id': vehicleId,
      'from': from,
      'to': to,
    };
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
    );
    return client.send<List<Trip>, Trip>($request);
  }
}
