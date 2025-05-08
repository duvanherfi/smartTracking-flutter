// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'geo_fence_datasource.dart';

// **************************************************************************
// ChopperGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
final class _$GeoFenceDataSource extends GeoFenceDataSource {
  _$GeoFenceDataSource([ChopperClient? client]) {
    if (client == null) return;
    this.client = client;
  }

  @override
  final Type definitionType = GeoFenceDataSource;

  @override
  Future<Response<List<GeoFence>>> getGeoFences() {
    final Uri $url = Uri.parse('/geo_fences');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<List<GeoFence>, GeoFence>($request);
  }

  @override
  Future<Response<GeoFence>> createGeoFence(Map<String, GeoFence> body) {
    final Uri $url = Uri.parse('/geo_fences');
    final $body = body;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<GeoFence, GeoFence>($request);
  }
}
