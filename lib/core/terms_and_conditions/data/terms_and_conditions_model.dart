class TermsAndConditionsModel {
  int? id;
  String? termsConditions;

  TermsAndConditionsModel({this.id, this.termsConditions});

  TermsAndConditionsModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    termsConditions = json['termsConditions'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['termsConditions'] = termsConditions;
    return data;
  }
}