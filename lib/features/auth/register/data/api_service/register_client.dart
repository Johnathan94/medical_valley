import 'package:dio/dio.dart';
import 'package:medical_valley/features/auth/register/data/model/register_request_model.dart';
import 'package:retrofit/retrofit.dart';
part 'register_client.g.dart';
@RestApi()
abstract class RegisterClient {
  @POST("/User/SignUp")
  Future<RegisterRequestModel> register(@Body() RegisterRequestModel requestModel);
  factory RegisterClient(Dio dio, {String baseUrl}) = _RegisterClient;

}