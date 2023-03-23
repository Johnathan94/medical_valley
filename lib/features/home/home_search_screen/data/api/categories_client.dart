
import 'package:dio/dio.dart';

class CategoriesClient {
  Dio dio ;

  CategoriesClient(this.dio);

  getCategories()async{
    Response response =  await dio.get("${dio.options.baseUrl}/Service/Categories",);
    return response.data;
  }
}