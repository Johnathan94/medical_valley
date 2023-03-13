class NegotiateModel {
  List<NegotiateData>? data;

  NegotiateModel({this.data});

  NegotiateModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <NegotiateData>[];
      json['data'].forEach((v) {
        data!.add( NegotiateData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class NegotiateData {
  int? offerId;

  NegotiateData({this.offerId});

  NegotiateData.fromJson(Map<String, dynamic> json) {
    offerId = json['offerId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['offerId'] = offerId;
    return data;
  }
}
