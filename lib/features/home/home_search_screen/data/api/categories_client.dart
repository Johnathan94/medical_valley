
import 'package:dio/dio.dart';

class CategoriesClient {
  Dio dio ;

  CategoriesClient(this.dio);

  getCategories(int page , int pageSize)async{
    Response response =  await dio.get("${dio.options.baseUrl}/Service/Categories?PageNumber=$page&PageSize=$pageSize",);
    return response.data;
  }
}