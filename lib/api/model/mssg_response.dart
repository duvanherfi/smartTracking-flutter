import 'package:json_annotation/json_annotation.dart';

part 'mssg_response.g.dart';

@JsonSerializable(explicitToJson: true, includeIfNull: true, nullable: true)
class MssgResponse {

  @JsonKey(name: 'mssg')
  String? mssg;

  MssgResponse(this.mssg);

  factory MssgResponse.fromJson(Map<String, dynamic> json) =>
      _$MssgResponseFromJson(json);

  Map<String, dynamic> toJson() => _$MssgResponseToJson(this);

}