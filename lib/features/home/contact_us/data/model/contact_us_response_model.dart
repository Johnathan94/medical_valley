class ContactUsResponse {
  bool? succeeded;
  String? message;
  String? messageCode;
  int? responseCode;
  String? validationIssue;
  ContactUsModel? data;

  ContactUsResponse(
      {this.succeeded,
        this.message,
        this.messageCode,
        this.responseCode,
        this.validationIssue,
        this.data});

  ContactUsResponse.fromJson(Map<String, dynamic> json) {
    succeeded = json['succeeded'];
    message = json['message'];
    messageCode = json['messageCode'];
    responseCode = json['responseCode'];
    validationIssue = json['validationIssue'];
    data = json['data'] != null ?  ContactUsModel.fromJson(json['data']) : null;
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

class ContactUsModel {
  String? fullName;
  String? email;
  String? phone;
  String? problem;

  ContactUsModel({this.fullName, this.email, this.phone, this.problem});

  ContactUsModel.fromJson(Map<String, dynamic> json) {
    fullName = json['fullName'];
    email = json['email'];
    phone = json['phone'];
    problem = json['problem'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['fullName'] = fullName;
    data['email'] = email;
    data['phone'] = phone;
    data['problem'] = problem;
    return data;
  }
}
