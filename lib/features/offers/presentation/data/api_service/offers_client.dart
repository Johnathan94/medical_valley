import 'package:dio/dio.dart';

class OffersClient {
  Dio dio;

  OffersClient(this.dio);

  getOffers(int page, int pageSize, int userId, int requestId) async {
    Response response = await dio.get(
      "${dio.options.baseUrl}/Request/Offers?PageNumber=$page&PageSize=$pageSize&UserId=$userId&requestId=$requestId",
    );
    return response.data;
  }
}
