import 'package:dio/dio.dart';

class GetInvoiceClient {
  Dio dio;

  GetInvoiceClient(this.dio);

  getInvoice(String invoiceId) async {
    Response response = await dio.get(
      "https://alpha.api.medvalley-sa.com/api/Payments/GetInvoiceInfo?InvID=$invoiceId&api-version=1",
    );
    return response.data;
  }
}
