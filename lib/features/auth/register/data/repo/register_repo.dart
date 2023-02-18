import 'package:dartz/dartz.dart';
import 'package:medical_valley/core/failures/failures.dart';
import 'package:medical_valley/features/auth/register/data/api_service/register_client.dart';
import 'package:medical_valley/features/auth/register/data/model/register_request_model.dart';

abstract class RegisterUserRepo {
  Future<Either<Failure , Unit>> register (RegisterRequestModel model);
}
 class RegisterUserRepoImpl extends RegisterUserRepo{
  RegisterClient client ;

  RegisterUserRepoImpl(this.client);

  @override
  Future<Either<Failure , Unit>> register(RegisterRequestModel model) async {
    try
     {
       var result = await client.register(model);
        if(result["responseCode"] >= 200 && result["responseCode"] < 300 ){
       return const Right(unit);
     }else {
          return Left(ServerFailure(error: result["message"]));
        }
     }
      catch(e){
      return Left(ServerFailure(error: e.toString()));
     }
  }
}