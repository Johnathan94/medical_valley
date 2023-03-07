
import 'package:dio/dio.dart';
class OffersClient{
  Dio dio ;

  OffersClient(this.dio);

  getOffers(int page , int pageSize , int serviceId , int categoryId)async{
    Response response =  await dio.get("${dio.options.baseUrl}/Provider/Offers?PageNumber=$page&PageSize=$pageSize&CategoryId=$categoryId&ServiceId=$serviceId",);
    return response.data;
  }

}