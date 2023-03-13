
import 'package:dio/dio.dart';
import 'package:medical_valley/features/offers/presentation/data/model/negotiate_model.dart';

class NegotiateClient{
  Dio dio ;

  NegotiateClient(this.dio);

  negotiate(NegotiateModel model)async{
    Response response =  await dio.post("${dio.options.baseUrl}/Request/Negotiate",data: model.toJson());
    return response.data;
  }

}