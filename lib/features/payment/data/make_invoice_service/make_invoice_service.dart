import 'package:dio/dio.dart';

class MakeInvoiceClient {
  Dio dio;

  MakeInvoiceClient(this.dio);

  makeInvoice(int offerId) async {
    Response response = await dio.get(
      "https://alpha.api.medvalley-sa.com/api/Payments/MakeInvoice?OfferID=$offerId&api-version=1",
    );
    return response.data;
  }
}
