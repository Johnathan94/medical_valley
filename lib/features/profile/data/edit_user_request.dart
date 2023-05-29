class UpdateUserRequest {
  int? id;
  String? fullName;
  String? email;
  bool? haveInsurance;
  String? nationalId;
  String? birthDate;
  int? genderId;
  String? location;
  int? latitude;
  int? longitude;

  UpdateUserRequest(
      {required this.id,
      required this.fullName,
      required this.email,
      this.haveInsurance,
      required this.nationalId,
      required this.birthDate,
      required this.genderId,
      required this.location,
      required this.latitude,
      required this.longitude});

  UpdateUserRequest.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fullName = json['fullName'];
    email = json['email'];
    haveInsurance = json['haveInsurance'];
    nationalId = json['nationalId'];
    birthDate = json['birthDate'];
    genderId = json['genderId'];
    location = json['location'];
    latitude = json['latitude'];
    longitude = json['longitude'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['fullName'] = fullName;
    data['email'] = email;
    data['haveInsurance'] = haveInsurance;
    data['nationalId'] = nationalId;
    data['birthDate'] = birthDate;
    data['genderId'] = genderId;
    data['location'] = location;
    data['latitude'] = latitude;
    data['longitude'] = longitude;
    return data;
  }
}
