import 'package:dartz/dartz.dart';
import 'package:medical_valley/core/failures/failures.dart';
import 'package:medical_valley/features/profile/data/edit_user_request.dart';
import 'package:medical_valley/features/profile/data/edit_user_response.dart';
import 'package:medical_valley/features/profile/data/user_api.dart';

abstract class UpdateUserUseCase {
  Future<Either<ServerFailure, Unit>> updateUser(UpdateUserRequest request);
}

class UpdateUserUseCaseImpl extends UpdateUserUseCase {
  UserClient userClient;

  UpdateUserUseCaseImpl(this.userClient);

  @override
  Future<Either<ServerFailure, Unit>> updateUser(UpdateUserRequest request ) async {
    try {
      var result = await userClient.updateUserData(request);
      var updateUserResponse = UpdateUserResponse.fromJson(result);
      if (updateUserResponse.responseCode! >= 200 && updateUserResponse.responseCode! < 300) {
        return const Right(unit);
      }
      return Left(ServerFailure(error: updateUserResponse.message));
    } catch (e) {
      return Left(ServerFailure(error: e.toString()));
    }
  }
}
