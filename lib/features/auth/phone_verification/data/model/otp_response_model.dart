class OtpResponse {
  bool? succeeded;
  String? message;
  String? messageCode;
  int? responseCode;
  String? validationIssue;
  Data? data;

  OtpResponse(
      {this.succeeded,
        this.message,
        this.messageCode,
        this.responseCode,
        this.validationIssue,
        this.data});

  OtpResponse.fromJson(Map<String, dynamic> json) {
    succeeded = json['succeeded'];
    message = json['message'];
    messageCode = json['messageCode'];
    responseCode = json['responseCode'];
    validationIssue = json['validationIssue'];
    data = json['data'] != null ?  Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  {};
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
  OtpData? otpData;
  String? token;

  Data({this.otpData, this.token});

  Data.fromJson(Map<String, dynamic> json) {
    otpData =
    json['data'] != null ?  OtpData.fromJson(json['data']) : null;
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  {};
    if (otpData != null) {
      data['data'] = otpData!.toJson();
    }
    data['token'] = token;
    return data;
  }
}

class OtpData {
  bool? succeeded;
  String? message;
  String? messageCode;
  int? responseCode;
  String? validationIssue;
  UserDate? userDate;

  OtpData(
      {this.succeeded,
        this.message,
        this.messageCode,
        this.responseCode,
        this.validationIssue,
        this.userDate});

  OtpData.fromJson(Map<String, dynamic> json) {
    succeeded = json['succeeded'];
    message = json['message'];
    messageCode = json['messageCode'];
    responseCode = json['responseCode'];
    validationIssue = json['validationIssue'];
    userDate = json['data'] != null
        ?  UserDate.fromJson(json['data'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['succeeded'] = succeeded;
    data['message'] = message;
    data['messageCode'] = messageCode;
    data['responseCode'] = responseCode;
    data['validationIssue'] = validationIssue;
    if (userDate != null) {
      data['data'] = userDate!.toJson();
    }
    return data;
  }
}

class UserDate {
  int? id;
  String? fullName;
  String? email;
  String? mobile;
  bool? hasInsurance;
  int? genderId;
  String? genderStr;
  String? notes;
  int? statusId;
  String? statusStr;
  String? location;
  double? latitude;
  double? longitude;

  UserDate(
      {this.id,
        this.fullName,
        this.email,
        this.mobile,
        this.hasInsurance,
        this.genderId,
        this.genderStr,
        this.notes,
        this.statusId,
        this.statusStr,
        this.location,
        this.latitude,
        this.longitude});

  UserDate.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fullName = json['fullName'];
    email = json['email'];
    mobile = json['mobile'];
    hasInsurance = json['hasInsurance'];
    genderId = json['genderId'];
    genderStr = json['genderStr'];
    notes = json['notes'];
    statusId = json['statusId'];
    statusStr = json['statusStr'];
    location = json['location'];
    latitude = json['latitude'];
    longitude = json['longitude'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['fullName'] = fullName;
    data['email'] = email;
    data['mobile'] = mobile;
    data['hasInsurance'] = hasInsurance;
    data['genderId'] = genderId;
    data['genderStr'] = genderStr;
    data['notes'] = notes;
    data['statusId'] = statusId;
    data['statusStr'] = statusStr;
    data['location'] = location;
    data['latitude'] = latitude;
    data['longitude'] = longitude;
    return data;
  }
}
