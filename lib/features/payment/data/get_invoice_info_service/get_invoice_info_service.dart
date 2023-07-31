import 'package:dio/dio.dart';

class GetInvoiceInfoService {
  Dio dio;

  GetInvoiceInfoService(this.dio);

  getInvoiceService(String uuid) async {
    Response response = await dio.post(
      "${dio.options.baseUrl}/Payments/GetInvoiceInfo?InvID=$uuid",
    );
    return response.data;
  }
}
