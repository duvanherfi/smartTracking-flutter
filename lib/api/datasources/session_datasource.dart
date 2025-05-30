import 'package:chopper/chopper.dart';
import 'package:smart_tracking/api/model/session.dart';
import 'package:smart_tracking/api/model/session_response.dart';

part 'session_datasource.chopper.dart';

@ChopperApi(baseUrl: "/sessions")
abstract class SessionDataSource extends ChopperService {

  @PUT(path: "{id}")
  Future<Response<SessionResponse>> updateSession(
      @Path("id") String id,
      @Body()  Session session,
  );

  static _$SessionDataSource create([ChopperClient? client]) =>
      _$SessionDataSource(client);
}
