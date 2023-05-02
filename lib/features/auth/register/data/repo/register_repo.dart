import 'package:dartz/dartz.dart';
import 'package:medical_valley/core/failures/failures.dart';
import 'package:medical_valley/features/auth/login/data/model/login_respoonse_model.dart';
import 'package:medical_valley/features/auth/register/data/api_service/register_client.dart';
import 'package:medical_valley/features/auth/register/data/model/register_request_model.dart';

abstract class RegisterUserRepo {
  Future<Either<Failure , String>> register (RegisterRequestModel model);
}
 class RegisterUserRepoImpl extends RegisterUserRepo{
  RegisterClient client ;

  RegisterUserRepoImpl(this.client);

  @override
  Future<Either<Failure , String>> register(RegisterRequestModel model) async {
    try
     {
       var result = await client.register(model);
       var registerResponse = LoginResponse.fromJson(result);
        if(registerResponse.responseCode == 200 ){
       return  Right(registerResponse.data ?? "");
     }else {
          return Left(ServerFailure(error: registerResponse.message));
        }
     }
      catch(e){
      return Left(ServerFailure(error: "something went wrong"));
     }
  }
}