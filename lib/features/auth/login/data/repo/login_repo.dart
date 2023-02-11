import 'package:dartz/dartz.dart';
import 'package:medical_valley/core/failures/failures.dart';
import 'package:medical_valley/core/shared_pref/shared_pref.dart';
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
       var result = await client.login(mobile);
       if(result["result"]["responseCode"]==200){
          LocalStorageManager.saveUser(result);
         return const Right(unit);
       }
       return Left(ServerFailure());
     }
      catch(e){
      return Left(ServerFailure());
     }
  }
}