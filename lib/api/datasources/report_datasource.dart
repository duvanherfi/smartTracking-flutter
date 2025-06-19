import 'package:chopper/chopper.dart';
import 'package:smart_tracking/api/model/trip.dart';

part 'report_datasource.chopper.dart';

@ChopperApi(baseUrl: "/reports")
abstract class ReportDataSource extends ChopperService {

  @GET(path: "trips")
  Future<Response<List<Trip>>> getTravels(
      @Query("vehicle_id") String vehicleId,
      @Query() String from,
      @Query() String to,
  );

  static _$ReportDataSource create([ChopperClient? client]) =>
      _$ReportDataSource(client);
}
