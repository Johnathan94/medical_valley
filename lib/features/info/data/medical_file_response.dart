class MedicalFileResponse {
  bool? succeeded;
  String? message;
  String? messageCode;
  int? responseCode;
  String? validationIssue;
  MedicalFileModel? data;

  MedicalFileResponse(
      {this.succeeded,
        this.message,
        this.messageCode,
        this.responseCode,
        this.validationIssue,
        this.data});

  MedicalFileResponse.fromJson(Map<String, dynamic> json) {
    succeeded = json['succeeded'];
    message = json['message'];
    messageCode = json['messageCode'];
    responseCode = json['responseCode'];
    validationIssue = json['validationIssue'];
    data = json['data'] != null ?  MedicalFileModel.fromJson(json['data']) : null;
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

class MedicalFileModel {
  int? id;
  String? fullName;
  String? email;
  String? mobile;
  String? notes;
  int? statusId;
  String? statusStr;
  bool? hasInsurance;
  String? nationalId;
  String? insuranceNumber;
  String? birthDate;
  int? genderId;
  String? genderStr;
  String? location;
  double? latitude;
  double? longitude;

  MedicalFileModel(
      {this.id,
        this.fullName,
        this.email,
        this.mobile,
        this.notes,
        this.statusId,
        this.statusStr,
        this.hasInsurance,
        this.nationalId,
        this.insuranceNumber,
        this.birthDate,
        this.genderId,
        this.genderStr,
        this.location,
        this.latitude,
        this.longitude});

  MedicalFileModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fullName = json['fullName'];
    email = json['email'];
    mobile = json['mobile'];
    notes = json['notes'];
    statusId = json['statusId'];
    statusStr = json['statusStr'];
    hasInsurance = json['hasInsurance'];
    nationalId = json['nationalId'];
    insuranceNumber = json['insuranceNumber'];
    birthDate = json['birthDate'];
    genderId = json['genderId'];
    genderStr = json['genderStr'];
    location = json['location'];
    latitude = json['latitude'];
    longitude = json['longitude'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  {};
    data['id'] = id;
    data['fullName'] = fullName;
    data['email'] = email;
    data['mobile'] = mobile;
    data['notes'] = notes;
    data['statusId'] = statusId;
    data['statusStr'] = statusStr;
    data['hasInsurance'] = hasInsurance;
    data['nationalId'] = nationalId;
    data['insuranceNumber'] = insuranceNumber;
    data['birthDate'] = birthDate;
    data['genderId'] = genderId;
    data['genderStr'] = genderStr;
    data['location'] = location;
    data['latitude'] = latitude;
    data['longitude'] = longitude;
    return data;
  }
}
