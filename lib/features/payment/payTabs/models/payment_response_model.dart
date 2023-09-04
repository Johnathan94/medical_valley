class PaymentResponseModel {
  final bool isSuccess;
  final String? status;
  PaymentResponseModel({
    required this.isSuccess,
    this.status,
  });

  factory PaymentResponseModel.fromJson(Map<String, dynamic> json) {
    return PaymentResponseModel(
      isSuccess: json['isSuccess'],
      status: json['status'],
    );
  }
}
