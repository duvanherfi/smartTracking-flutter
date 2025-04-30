import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:chopper/chopper.dart';
import 'package:smart_tracking/api/model/sesion.dart';
import 'package:smart_tracking/api/model/session_response.dart';

part 'login_datasource.chopper.dart';

@ChopperApi(baseUrl: "/sessions")
abstract class LoginDataSource extends ChopperService {
  @POST(path: "login")
  Future<Response<SessionResponse>> login(@body Session request);

  static _$LoginDataSource create([ChopperClient? client]) =>
      _$LoginDataSource(client);
}
