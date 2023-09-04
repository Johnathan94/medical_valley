class InvoiceDetailsModel {
  final double amount;
  final String invoiceID;
  final String? cardNumber;
  final String? transactionToken;
  final String? transactionReference;

  InvoiceDetailsModel({
    required this.amount,
    required this.invoiceID,
    this.cardNumber,
    this.transactionToken,
    this.transactionReference,
  });
  factory InvoiceDetailsModel.fromJson(Map<String, dynamic> json) {
    return InvoiceDetailsModel(
      amount: json['amount'],
      invoiceID: json['invoiceID'],
      cardNumber: json['paymentMethodCardNumber'],
      transactionToken: json['transactionToken'],
      transactionReference: json['transactionReference'],
    );
  }
}
