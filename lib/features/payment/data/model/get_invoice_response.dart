class GetInvoiceResponse {
  bool? succeeded;
  String? message;
  String? messageCode;
  int? responseCode;
  String? validationIssue;
  Data? data;

  GetInvoiceResponse(
      {this.succeeded,
      this.message,
      this.messageCode,
      this.responseCode,
      this.validationIssue,
      this.data});

  GetInvoiceResponse.fromJson(Map<String, dynamic> json) {
    succeeded = json['succeeded'];
    message = json['message'];
    messageCode = json['messageCode'];
    responseCode = json['responseCode'];
    validationIssue = json['validationIssue'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
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

class Data {
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
  String? currency;
  double? totalPaid;
  String? cardType;
  String? paymentMethodCardNumber;
  int? expm;
  int? expy;

  Data(
      {this.invoiceID,
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
      this.expy});

  Data.fromJson(Map<String, dynamic> json) {
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

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['invoiceID'] = invoiceID;
    data['userID'] = userID;
    data['providerID'] = providerID;
    data['requestID'] = requestID;
    data['paid'] = paid;
    data['issuedAt'] = issuedAt;
    data['paidAt'] = paidAt;
    data['amount'] = amount;
    data['subtotal'] = subtotal;
    data['vat'] = vat;
    data['isTaxIncluded'] = isTaxIncluded;
    data['currency'] = currency;
    data['totalPaid'] = totalPaid;
    data['cardType'] = cardType;
    data['paymentMethodCardNumber'] = paymentMethodCardNumber;
    data['expm'] = expm;
    data['expy'] = expy;
    return data;
  }
}
