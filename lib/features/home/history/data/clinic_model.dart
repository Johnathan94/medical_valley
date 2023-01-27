
class Clinics {
  List<Items>? items;

  Clinics({this.items});

  Clinics.fromJson(Map<String, dynamic> json) {
    if (json['items'] != null) {
      items = <Items>[];
      json['items'].forEach((v) {
        items!.add( Items.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    if (items != null) {
      data['items'] = items!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
class Items {
  String? clinicName;
  String? image;
  double? lat;
  double? lng;
  double? price;
  int? timeAgo;
  String? timeUnit;
  double? rate;
  double? distance;
  String? distanceUnit;
  String? address;

  Items(
      {this.clinicName,
        this.image,
        this.lat,
        this.lng,
        this.price,
        this.timeAgo,
        this.distance,
        this.timeUnit,
        this.rate,
        this.address});

  Items.fromJson(Map<String, dynamic> json) {
    clinicName = json['clinic_name'];
    image = json['image'];
    lat = json['lat'];
    lng = json['lng'];
    price = json['price'];
    distance = double.parse(json['distance'] .toString());
    distanceUnit = json['distance_unit'];
    timeAgo = json['time_ago'];
    timeUnit = json['time_unit'];
    rate = json['rate'];
    address = json['address'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['clinic_name'] = clinicName;
    data['distance_unit'] = distanceUnit;
    data['image'] = image;
    data['lat'] = lat;
    data['distance'] = distance;
    data['lng'] = lng;
    data['price'] = price;
    data['time_ago'] = timeAgo;
    data['time_unit'] = timeUnit;
    data['rate'] = rate;
    data['address'] = address;
    return data;
  }
}
