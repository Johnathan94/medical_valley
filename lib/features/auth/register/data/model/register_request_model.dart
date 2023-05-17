import 'package:json_annotation/json_annotation.dart';

part 'register_request_model.g.dart';

@JsonSerializable()
class RegisterRequestModel {
  @JsonKey(name: "fullName")
  String? fullName;
  @JsonKey(name: "email")
  String? email;
  @JsonKey(name: "mobile")
  String? mobile;
  @JsonKey(name: "hasInsurance")
  bool? haveInsurance;
  @JsonKey(name: "genderId")
  int? genderId;

  RegisterRequestModel({
    this.fullName,
    this.email,
    this.mobile,
    this.haveInsurance,
    this.genderId,
  });
  factory RegisterRequestModel.fromJson(Map<String, dynamic> json) =>
      _$RegisterRequestModelFromJson(json);

  Map<String, dynamic> toJson() => _$RegisterRequestModelToJson(this);
}
