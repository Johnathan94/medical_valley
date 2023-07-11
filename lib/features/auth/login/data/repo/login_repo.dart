import 'package:dartz/dartz.dart';
import 'package:medical_valley/core/failures/failures.dart';
import 'package:medical_valley/features/auth/login/data/api_service/login_client.dart';
import 'package:medical_valley/features/auth/login/data/model/login_respoonse_model.dart';

abstract class LoginRepo {
  Future<Either<ServerFailure, String>> login(String mobile);
}

class LoginRepoImpl extends LoginRepo {
  LoginClient client;

  LoginRepoImpl(this.client);

  @override
  Future<Either<ServerFailure, String>> login(String mobile) async {
    try {
      var result = await client.login(mobile);
      var loginResponse = LoginResponse.fromJson(result);
      if (loginResponse.responseCode == 200) {
        return Right(loginResponse.data ?? "");
      }
      return Left(ServerFailure(error: loginResponse.message));
    } catch (e) {
      return Left(ServerFailure());
    }
  }
}
