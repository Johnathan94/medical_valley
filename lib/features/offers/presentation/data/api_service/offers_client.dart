
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:medical_valley/core/shared_pref/shared_pref.dart';

class OffersClient{
  Dio dio ;

  OffersClient(this.dio);

  getOffers(int page , int pageSize , int serviceId , int categoryId , int userId)async{
    String userEncoded = LocalStorageManager.getUser();
    Map<String, dynamic> user = jsonDecode(userEncoded);
    Response response =  await dio.get("${dio.options.baseUrl}/Request/Offers?PageNumber=$page&PageSize=$pageSize&CategoryId=$categoryId&ServiceId=$serviceId&UserId=${user["result"]["data"]["id"]}",);
    return response.data;
  }

}