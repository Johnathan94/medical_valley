import 'package:dio/dio.dart';

class MakeInvoiceClient {
  Dio dio;

  MakeInvoiceClient(this.dio);

  makeInvoice(int offerId) async {
    Response response = await dio.post(
      "${dio.options.baseUrl}/Payments/MakeInvoice?OfferID=$offerId",
    );
    return response.data;
  }
}
