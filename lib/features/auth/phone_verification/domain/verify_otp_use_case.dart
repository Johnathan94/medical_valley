import 'package:dartz/dartz.dart';
import 'package:medical_valley/core/failures/failures.dart';
import 'package:medical_valley/core/shared_pref/shared_pref.dart';
import 'package:medical_valley/features/auth/phone_verification/data/model/otp_response_model.dart';
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
      var otpResponse = OtpResponse.fromJson(result);
      if (otpResponse.responseCode! >= 200 && otpResponse.responseCode! < 300) {
        LocalStorageManager.saveUser(otpResponse.data!.otpData!.userDate!.toJson());
        LocalStorageManager.saveToken(otpResponse.data!.token!);
        return const Right(unit);
      }
      return Left(ServerFailure());
    } catch (e) {
      return Left(ServerFailure());
    }
  }
}
