import 'package:json_annotation/json_annotation.dart';

part 'sesion.g.dart';

@JsonSerializable(includeIfNull: false)
class Session {
  @JsonKey(name: 'phone')
  String? phone;
  @JsonKey(name: 'password')
  String? password;

  Session({this.phone, this.password});

  factory Session.fromJson(Map<String, dynamic> json) =>
      _$SessionFromJson(json);

  Map<String, dynamic> toJson() => _$SessionToJson(this);
}
