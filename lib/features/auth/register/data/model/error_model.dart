import 'package:json_annotation/json_annotation.dart';
part 'error_model.g.dart';

@JsonSerializable()
class ErrorModel {
  @JsonKey(name: 'type')
  String? type;
  @JsonKey(name: 'title')
  String? title;
  @JsonKey(name: 'status')
  int? status;
  @JsonKey(name: 'detail')
  String? detail;
  @JsonKey(name: 'instance')
  String? instance;
  @JsonKey(name: 'additionalProp1')
  String? additionalProp1;
  @JsonKey(name: 'additionalProp2')
  String? additionalProp2;
  @JsonKey(name: 'additionalProp3')
  String? additionalProp3;

  ErrorModel(
      {this.type,
        this.title,
        this.status,
        this.detail,
        this.instance,
        this.additionalProp1,
        this.additionalProp2,
        this.additionalProp3});
  factory ErrorModel.fromJson(Map<String, dynamic> json) => _$ErrorModelFromJson(json);

  Map<String, dynamic> toJson() => _$ErrorModelToJson(this);

}