class NegotiateModel {
  int? userId;
  List<int>? offers;

  NegotiateModel({this.userId, this.offers});

  NegotiateModel.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    offers = json['offers'].cast<int>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['userId'] = userId;
    data['offers'] = offers;
    return data;
  }
}
