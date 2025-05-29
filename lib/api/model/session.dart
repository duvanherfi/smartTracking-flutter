import 'package:json_annotation/json_annotation.dart';

part 'session.g.dart';

@JsonSerializable(includeIfNull: false)
class Session {
  @JsonKey(name: '_id')
  String id;
  @JsonKey(name: 'token')
  String token;
  @JsonKey(name: 'push_token')
  String pushToken;

  Session({
    required this.id,
    required this.token,
    required this.pushToken,
  });

  factory Session.fromJson(Map<String, dynamic> json) =>
      _$SessionFromJson(json);

  Map<String, dynamic> toJson() => _$SessionToJson(this);
}
