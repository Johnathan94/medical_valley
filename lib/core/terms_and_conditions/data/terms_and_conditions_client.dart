import 'package:dio/dio.dart';

class TermsAndConditionsClient{

  Dio dio;
  TermsAndConditionsClient(this.dio);

  getTermsAndConditions() async {
    Response response = await dio
        .get("${dio.options.baseUrl}/Provider/GetTermsAndConditions");
    return response.data;
  }
}

