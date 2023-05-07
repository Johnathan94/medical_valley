class MedicalFileRequest {
  int? id;
  bool? hasInsurance;
  String? nationalId;
  String? insuranceNumber;
  String? birthDate;
  int? genderId;

  MedicalFileRequest(
      {this.id,
        this.hasInsurance,
        this.nationalId,
        this.insuranceNumber,
        this.birthDate,
        this.genderId});

  MedicalFileRequest.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    hasInsurance = json['hasInsurance'];
    nationalId = json['nationalId'];
    insuranceNumber = json['insuranceNumber'];
    birthDate = json['birthDate'];
    genderId = json['genderId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['hasInsurance'] = hasInsurance;
    data['nationalId'] = nationalId;
    data['insuranceNumber'] = insuranceNumber;
    data['birthDate'] = birthDate;
    data['genderId'] = genderId;
    return data;
  }
}
