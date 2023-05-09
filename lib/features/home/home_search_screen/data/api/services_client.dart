
import 'package:dio/dio.dart';

class ServicesClient {
  Dio dio ;

  ServicesClient(this.dio);

  getServices(int categoryId , int pageNumber , int pageSize)async{
    Response response =  await dio.get("${dio.options.baseUrl}/Service/AllSystemServices?PageNumber=$pageNumber&PageSize=$pageSize&categoryId=$categoryId",);
    return response.data;
  }
}