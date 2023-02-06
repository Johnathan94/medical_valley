import 'package:json_annotation/json_annotation.dart';
part 'register_request_model.g.dart';
@JsonSerializable()
class RegisterRequestModel {
  @JsonKey(name: "id")
  int? id;
  @JsonKey(name: "fullName")
  String? fullName;
  @JsonKey(name: "email")
  String? email;
  @JsonKey(name: "mobile")
  String? mobile;
  @JsonKey(name: "haveInsurance")
  bool? haveInsurance;
  @JsonKey(name: "insuranceCompanyId")
  int? insuranceCompanyId;
  @JsonKey(name: "nationalId")
  String? nationalId;
  @JsonKey(name: "birthDate")
  String? birthDate;
  @JsonKey(name: "genderId")
  int? genderId;
  @JsonKey(name: "userTypeId")
  int? userTypeId;
  @JsonKey(name: "notes")
  String? notes;
  @JsonKey(name: "genderStr")
  String? genderStr;
  @JsonKey(name: "insuranceCompanyStr")
  String? insuranceCompanyStr;
  @JsonKey(name: "rememberMe")
  bool? rememberMe;

  RegisterRequestModel(
      {this.id =1,
        this.fullName,
        this.email,
        this.mobile,
        this.haveInsurance,
        this.insuranceCompanyId,
        this.nationalId,
        this.birthDate,
        this.genderId,
        this.userTypeId=1,
        this.notes,
        this.genderStr,
        this.insuranceCompanyStr,
        this.rememberMe});
 factory RegisterRequestModel.fromJson(Map<String, dynamic> json) => _$RegisterRequestModelFromJson(json);

  Map<String, dynamic> toJson() => _$RegisterRequestModelToJson(this);


}