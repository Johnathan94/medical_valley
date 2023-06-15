class TermsAndConditionsModel {
  bool? succeeded;
  String? message;
  String? messageCode;
  int? responseCode;
  String? validationIssue;
  Data? data;

  TermsAndConditionsModel(
      {this.succeeded,
      this.message,
      this.messageCode,
      this.responseCode,
      this.validationIssue,
      this.data});

  TermsAndConditionsModel.fromJson(Map<String, dynamic> json) {
    succeeded = json['succeeded'];
    message = json['message'];
    messageCode = json['messageCode'];
    responseCode = json['responseCode'];
    validationIssue = json['validationIssue'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['succeeded'] = succeeded;
    data['message'] = message;
    data['messageCode'] = messageCode;
    data['responseCode'] = responseCode;
    data['validationIssue'] = validationIssue;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  int? logoImgeId;
  String? phoneNumber;
  String? email;
  String? aboutUs;
  String? termsConditions;

  Data(
      {this.logoImgeId,
      this.phoneNumber,
      this.email,
      this.aboutUs,
      this.termsConditions});

  Data.fromJson(Map<String, dynamic> json) {
    logoImgeId = json['logoImgeId'];
    phoneNumber = json['phoneNumber'];
    email = json['email'];
    aboutUs = json['aboutUs'];
    termsConditions = json['termsConditions'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['logoImgeId'] = logoImgeId;
    data['phoneNumber'] = phoneNumber;
    data['email'] = email;
    data['aboutUs'] = aboutUs;
    data['termsConditions'] = termsConditions;
    return data;
  }
}
