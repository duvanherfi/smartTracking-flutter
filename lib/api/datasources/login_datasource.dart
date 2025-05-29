import 'package:chopper/chopper.dart';
import 'package:smart_tracking/api/model/session_request.dart';
import 'package:smart_tracking/api/model/session_response.dart';

part 'login_datasource.chopper.dart';

@ChopperApi(baseUrl: "/sessions")
abstract class LoginDataSource extends ChopperService {
  @POST(path: "login")
  Future<Response<SessionResponse>> login(@body SessionRequest request);

  static _$LoginDataSource create([ChopperClient? client]) =>
      _$LoginDataSource(client);
}
