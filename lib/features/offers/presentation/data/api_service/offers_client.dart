
import 'package:dio/dio.dart';

class OffersClient{
  Dio dio ;

  OffersClient(this.dio);

  getOffers(int page , int pageSize , int serviceId , int categoryId , int userId)async{
    https://services.medvally.com/api/v1/Request/Offers?PageNumber=1&PageSize=10&UserId=30&CategoryId=11&ServiceId=24509

    Response response =  await dio.get("${dio.options.baseUrl}/Request/Offers?PageNumber=$page&PageSize=$pageSize&CategoryId=$categoryId&ServiceId=$serviceId&UserId=70",);
    return response.data;
  }

}