
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:medical_valley/core/shared_pref/shared_pref.dart';

class HistoryClient{
  Dio dio ;

  HistoryClient(this.dio);

  getHistoryNegotiations(int page , int pageSize ,{int? serviceId , int? categoryId })async{
    Response response;
    Map<String, dynamic> user  = LocalStorageManager.getUser();
    if(serviceId!= null && categoryId!= null){
      response =  await dio.get("${dio.options.baseUrl}/Request/Negotiations?PageNumber=$page&PageSize=$pageSize&CategoryId=$categoryId&ServiceId=$serviceId&UserId=${user["result"]["data"]["id"]}",);
    }else
    {
      response =  await dio.get("https://services.medvally.com/api/v1/Request/Negotiations?PageNumber=$page&PageSize=$pageSize&UserId=${user["data"]["data"]["id"]}",);
    }

    return response.data;
  }

}