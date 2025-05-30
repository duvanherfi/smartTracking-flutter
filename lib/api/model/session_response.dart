import 'package:json_annotation/json_annotation.dart';
import 'package:smart_tracking/api/model/user.dart';

part 'session_response.g.dart';

@JsonSerializable(explicitToJson: true, includeIfNull: true, nullable: true)
class SessionResponse {

  @JsonKey(name: 'user')
  User user;

  SessionResponse(this.user);

  factory SessionResponse.fromJson(Map<String, dynamic> json) =>
      _$SessionResponseFromJson(json);

  Map<String, dynamic> toJson() => _$SessionResponseToJson(this);

}