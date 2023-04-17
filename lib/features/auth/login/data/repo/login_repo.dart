import 'package:dartz/dartz.dart';
import 'package:medical_valley/core/failures/failures.dart';
import 'package:medical_valley/core/shared_pref/shared_pref.dart';
import 'package:medical_valley/features/auth/login/data/api_service/login_client.dart';

abstract class LoginRepo {
  Future<Either<Failure , String>> login (String mobile);
}
 class LoginRepoImpl extends LoginRepo{
  LoginClient client ;

  LoginRepoImpl(this.client);

  @override
  Future<Either<Failure , String>> login(String mobile) async {
    try
     {
       var result = await client.login(mobile);
       if(result["phone"]!=null){
         return  Right(result["phone"].toString());
       }
       return Left(ServerFailure());
     }
      catch(e){
      return Left(ServerFailure());
     }
  }
}