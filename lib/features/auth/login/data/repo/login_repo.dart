import 'package:dartz/dartz.dart';
import 'package:medical_valley/core/failures/failures.dart';
import 'package:medical_valley/features/auth/login/data/api_service/login_client.dart';

abstract class LoginRepo {
  Future<Either<Failure , Unit>> login (String mobile);
}
 class LoginRepoImpl extends LoginRepo{
  LoginClient client ;

  LoginRepoImpl(this.client);

  @override
  Future<Either<Failure , Unit>> login(String mobile) async {
    try
     {
       await client.login(mobile);
       return const Right(unit);
     }
      catch(e){
      return Left(ServerFailure());
     }
  }
}