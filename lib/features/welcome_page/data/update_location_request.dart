class UpdateLocationRequest {
  int? id;
  String? location;
  double? latitude;
  double? longitude;

  UpdateLocationRequest({this.location, this.latitude, this.longitude});

  UpdateLocationRequest.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    location = json['location'];
    latitude = json['latitude'];
    longitude = json['longitude'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['location'] = location;
    data['latitude'] = latitude;
    data['longitude'] = longitude;
    return data;
  }
}
