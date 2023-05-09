
import 'package:dio/dio.dart';

class SearchClient {
  Dio dio ;

  SearchClient(this.dio);

  searchWithKeyword(String keyword,int page , int pageSize)async{
    Response response =  await dio.get("${dio.options.baseUrl}/Service/AllSystemServices?PageNumber=$page&PageSize=$pageSize&name=$keyword",);
    return response.data;
  }
}