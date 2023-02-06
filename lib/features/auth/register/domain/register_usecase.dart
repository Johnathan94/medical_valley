
import 'package:dartz/dartz.dart';
import 'package:medical_valley/core/failures/failures.dart';
import 'package:medical_valley/features/auth/register/data/model/register_request_model.dart';
import 'package:medical_valley/features/auth/register/data/repo/register_repo.dart';

abstract class RegisterUseCase {
  Future<Either<Failure , Unit>> registerUser (RegisterRequestModel model);
}
 class RegisterUseCaseImpl extends RegisterUseCase{
  RegisterUserRepo registerUserRepo ;

  RegisterUseCaseImpl(this.registerUserRepo);

  @override
  Future<Either<Failure, Unit>> registerUser(RegisterRequestModel model) async{
    return await registerUserRepo.register(model);
  }

 }