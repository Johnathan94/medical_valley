class VerifyRequest {

  int? requestId;

  VerifyRequest({ this.requestId});

  VerifyRequest.fromJson(Map<String, dynamic> json) {
    requestId = json['requestId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['requestId'] = requestId;
    return data;
  }
}
