import 'package:dartz/dartz.dart';
import 'package:medical_valley/core/failures/failures.dart';
import 'package:medical_valley/core/shared_pref/shared_pref.dart';
import 'package:medical_valley/features/auth/phone_verification/data/otp_client.dart';

abstract class VerifyOtpUseCase {
  Future<Either<Failure, Unit>> verifyOtp(String otp, String mobile);
}

class VerifyOtpUseCaseImpl extends VerifyOtpUseCase {
  OtpClient otpClient;

  VerifyOtpUseCaseImpl(this.otpClient);

  @override
  Future<Either<Failure, Unit>> verifyOtp(String otp, String mobile) async {
    try {
      var result = await otpClient.verifyOtp(mobile, otp);
      if (result["data"] ["responseCode"]>= 200 && result["data"]["responseCode"] < 300) {
        LocalStorageManager.saveUser(result);
        return const Right(unit);
      }
      return Left(ServerFailure());
    } catch (e) {
      return Left(ServerFailure());
    }
  }
}
