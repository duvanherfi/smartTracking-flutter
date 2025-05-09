// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vehicle_datasource.dart';

// **************************************************************************
// ChopperGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
final class _$VehicleDataSource extends VehicleDataSource {
  _$VehicleDataSource([ChopperClient? client]) {
    if (client == null) return;
    this.client = client;
  }

  @override
  final Type definitionType = VehicleDataSource;

  @override
  Future<Response<List<Vehicle>>> getVehicles() {
    final Uri $url = Uri.parse('/vehicles');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<List<Vehicle>, Vehicle>($request);
  }

  @override
  Future<Response<AreaGeoJson>> getRecommended(String vehicleId) {
    final Uri $url = Uri.parse('/vehicles/${vehicleId}/recommended');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<AreaGeoJson, AreaGeoJson>($request);
  }
}
