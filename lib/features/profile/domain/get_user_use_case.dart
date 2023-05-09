import 'package:dartz/dartz.dart';
import 'package:medical_valley/core/failures/failures.dart';
import 'package:medical_valley/features/profile/data/get_user_response.dart';
import 'package:medical_valley/features/profile/data/user_api.dart';

abstract class GetUserUseCase {
  Future<Either<Failure, UserModel>> getUserData();
}

class GetUserUseCaseImpl extends GetUserUseCase {
  UserClient userClient;

  GetUserUseCaseImpl(this.userClient);

  @override
  Future<Either<Failure, UserModel>> getUserData() async {
    try {
      var result = await userClient.getUserData();
      var userResponse = GetUserResponse.fromJson(result);
      if (userResponse.responseCode! >= 200 && userResponse.responseCode! < 300) {
        return  Right(userResponse.data!);
      }
      return Left(ServerFailure());
    } catch (e) {
      return Left(ServerFailure());
    }
  }
}
