import 'package:dio/dio.dart';

class PackagesClient {
  Dio dio;

  PackagesClient(this.dio);

  getPackages(int categoryId, int pageNumber, int pageSize) async {
    Response response = await dio.get(
      "${dio.options.baseUrl}/Package/GetAll?PageNumber=$pageNumber&PageSize=$pageSize",
    );
    return response.data;
  }
}
