import 'package:chopper/chopper.dart';
import 'package:smart_tracking/api/model/mssg_response.dart';
import 'package:smart_tracking/api/model/session_response.dart';
import 'package:smart_tracking/api/model/user.dart';

part 'user_datasource.chopper.dart';

@ChopperApi(baseUrl: "/users")
abstract class UserDataSource extends ChopperService {

  @GET(path: "{id}")
  Future<Response<SessionResponse>> getUserInfo(@Path("id") String id);

  @PUT(path: "{id}")
  Future<Response<SessionResponse>> updateUser(
      @Path("id") String id,
      @Body()  User user,
  );

  @POST(path: "recovery_password")
  Future<Response<MssgResponse>> recoveryPassword(
      @Body()  Map<String, dynamic> body,
  );

  static _$UserDataSource create([ChopperClient? client]) =>
      _$UserDataSource(client);
}
