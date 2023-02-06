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
       await client.register(model);
       return const Right(unit);
     }
      catch(e){
      return Left(ServerFailure());
     }
  }
}