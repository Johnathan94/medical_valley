import 'package:dio/dio.dart';

class TermsAndConditionsClient {
  Dio dio;
  TermsAndConditionsClient(this.dio);

  getTermsAndConditions() async {
    Response response =
        await dio.get("${dio.options.baseUrl}/Misc/GetSettings");
    return response.data;
  }
}
