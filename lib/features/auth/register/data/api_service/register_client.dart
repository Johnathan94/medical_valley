import 'package:dio/dio.dart';
import 'package:medical_valley/features/auth/register/data/model/register_request_model.dart';
import 'package:retrofit/retrofit.dart';
 class RegisterClient {
  @POST("/User/SignUp")
  Dio dio ;

  RegisterClient(this.dio);

  register(RegisterRequestModel model)async{
    Response response =  await dio.post("${dio.options.baseUrl}/User/RegisterUser",data: model.toJson()
    );
    return response.data;
  }
}