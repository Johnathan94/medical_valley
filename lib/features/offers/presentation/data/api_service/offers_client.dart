
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:medical_valley/core/shared_pref/shared_pref.dart';

class OffersClient{
  Dio dio ;

  OffersClient(this.dio);

  getOffers(int page , int pageSize , int serviceId , int categoryId , int userId)async{
    Response response =  await dio.get("${dio.options.baseUrl}/Request/Offers?PageNumber=$page&PageSize=$pageSize&CategoryId=$categoryId&ServiceId=$serviceId&UserId=$userId",);
    return response.data;
  }

}