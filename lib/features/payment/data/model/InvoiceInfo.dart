import 'dart:convert';

/// succeeded : true
/// message : "Request Success"
/// messageCode : null
/// responseCode : 200
/// validationIssue : null
/// data : {"invoiceID":"90d61e2d-c0ad-41ae-d127-08dbc4f40cba","userID":1,"providerID":3,"requestID":1,"paid":false,"issuedAt":"2023-10-04T16:07:46.7684774","paidAt":"","amount":255.3,"subtotal":222,"vat":33.3,"isTaxIncluded":true,"currency":null,"totalPaid":0,"cardType":null,"paymentMethodCardNumber":"","expm":"","expy":""}

InvoiceInfo invoiceInfoFromJson(String str) =>
    InvoiceInfo.fromJson(json.decode(str));
String invoiceInfoToJson(InvoiceInfo data) => json.encode(data.toJson());

class InvoiceInfo {
  InvoiceInfo({
    this.succeeded,
    this.message,
    this.messageCode,
    this.responseCode,
    this.validationIssue,
    this.data,
  });

  InvoiceInfo.fromJson(dynamic json) {
    succeeded = json['succeeded'];
    message = json['message'];
    messageCode = json['messageCode'];
    responseCode = json['responseCode'];
    validationIssue = json['validationIssue'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
  bool? succeeded;
  String? message;
  dynamic messageCode;
  int? responseCode;
  dynamic validationIssue;
  Data? data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['succeeded'] = succeeded;
    map['message'] = message;
    map['messageCode'] = messageCode;
    map['responseCode'] = responseCode;
    map['validationIssue'] = validationIssue;
    if (data != null) {
      map['data'] = data?.toJson();
    }
    return map;
  }
}

/// invoiceID : "90d61e2d-c0ad-41ae-d127-08dbc4f40cba"
/// userID : 1
/// providerID : 3
/// requestID : 1
/// paid : false
/// issuedAt : "2023-10-04T16:07:46.7684774"
/// paidAt : ""
/// amount : 255.3
/// subtotal : 222
/// vat : 33.3
/// isTaxIncluded : true
/// currency : null
/// totalPaid : 0
/// cardType : null
/// paymentMethodCardNumber : ""
/// expm : ""
/// expy : ""

Data dataFromJson(String str) => Data.fromJson(json.decode(str));
String dataToJson(Data data) => json.encode(data.toJson());

class Data {
  Data({
    this.invoiceID,
    this.userID,
    this.providerID,
    this.requestID,
    this.paid,
    this.issuedAt,
    this.paidAt,
    this.amount,
    this.subtotal,
    this.vat,
    this.isTaxIncluded,
    this.currency,
    this.totalPaid,
    this.cardType,
    this.paymentMethodCardNumber,
    this.expm,
    this.expy,
  });

  Data.fromJson(dynamic json) {
    invoiceID = json['invoiceID'];
    userID = json['userID'];
    providerID = json['providerID'];
    requestID = json['requestID'];
    paid = json['paid'];
    issuedAt = json['issuedAt'];
    paidAt = json['paidAt'];
    amount = json['amount'];
    subtotal = json['subtotal'];
    vat = json['vat'];
    isTaxIncluded = json['isTaxIncluded'];
    currency = json['currency'];
    totalPaid = json['totalPaid'];
    cardType = json['cardType'];
    paymentMethodCardNumber = json['paymentMethodCardNumber'];
    expm = json['expm'];
    expy = json['expy'];
  }
  String? invoiceID;
  int? userID;
  int? providerID;
  int? requestID;
  bool? paid;
  String? issuedAt;
  String? paidAt;
  double? amount;
  double? subtotal;
  double? vat;
  bool? isTaxIncluded;
  dynamic currency;
  double? totalPaid;
  dynamic cardType;
  String? paymentMethodCardNumber;
  String? expm;
  String? expy;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['invoiceID'] = invoiceID;
    map['userID'] = userID;
    map['providerID'] = providerID;
    map['requestID'] = requestID;
    map['paid'] = paid;
    map['issuedAt'] = issuedAt;
    map['paidAt'] = paidAt;
    map['amount'] = amount;
    map['subtotal'] = subtotal;
    map['vat'] = vat;
    map['isTaxIncluded'] = isTaxIncluded;
    map['currency'] = currency;
    map['totalPaid'] = totalPaid;
    map['cardType'] = cardType;
    map['paymentMethodCardNumber'] = paymentMethodCardNumber;
    map['expm'] = expm;
    map['expy'] = expy;
    return map;
  }
}
