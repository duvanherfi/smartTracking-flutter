import 'package:json_annotation/json_annotation.dart';
import 'package:smart_tracking/api/model/session.dart';

part 'session_request.g.dart';

@JsonSerializable(includeIfNull: false)
class SessionRequest {
  @JsonKey(name: 'phone')
  String? phone;
  @JsonKey(name: 'password')
  String? password;
  @JsonKey(name: 'session')
  Session session;

  SessionRequest({required this.session, this.phone, this.password});

  factory SessionRequest.fromJson(Map<String, dynamic> json) =>
      _$SessionRequestFromJson(json);

  Map<String, dynamic> toJson() => _$SessionRequestToJson(this);
}
