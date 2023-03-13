class NegotiateModel {
  int? id;
  List<int>? offerId;

  NegotiateModel({this.id, this.offerId});

  NegotiateModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    offerId = json['offerId'].cast<int>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['offerId'] = offerId;
    return data;
  }
}
