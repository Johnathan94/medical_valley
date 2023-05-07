import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:medical_valley/core/base_service/flavors.dart';
import 'package:network_logger/network_logger.dart';

class DioManager {
  static  Dio? _dio ;

 static Dio getDio (){
    if(_dio == null ){
      _dio = Dio(BaseOptions(baseUrl: FlavorManager.currentFlavor.baseUrl));
      _dio!.interceptors.add(APIsInterceptors());
      _dio!.interceptors.add(DioNetworkLogger());
    }
    return _dio!;
 }
}
class APIsInterceptors extends Interceptor {



  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    var path = options.path;
    var baseUrl = options.baseUrl;
    debugPrint("url-> $baseUrl$path " );

    if (options.data != null) {
      var body = options.data;
      debugPrint("RequestBody $baseUrl$path -> \n $body => $path" );
    }
    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    var data = response.data;
    var path = response.requestOptions.path;
    debugPrint("Response  ->  \n $data => $path" );
    super.onResponse(response, handler);
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    var baseUrl = err.requestOptions.baseUrl;
    var path = err.requestOptions.path;
    debugPrint(
        "ErrorResponse $baseUrl$path ->  \n statusCode: ${err.response?.statusCode} ${err.response?.statusMessage}"
            " \n message: ${err.response?.data }  $path");

    super.onError(err, handler);
  }
}


