import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:medical_valley/features/auth/phone_verification/data/models/request/otp_request_model.dart';

import '../../../../../core/failures/failures.dart';
import '../../../../../core/shared_pref/shared_pref.dart';
import '../api_service/otp_verification_client.dart';

abstract class OtpPhoneVerificationRepo {
  Future<Either<Failure, Unit>> otpPhoneVerification(OtpRequestModel otpRequestModel);
}

class OtpPhoneVerificationImpl extends OtpPhoneVerificationRepo {
  OtpVerificationClient otpVerificationClient;

  OtpPhoneVerificationImpl(this.otpVerificationClient);

  @override
  Future<Either<Failure, Unit>> otpPhoneVerification(OtpRequestModel otpRequestModel) async {
    try {
      var result = await otpVerificationClient.sendCode(otpRequestModel);
      if (result["result"]["responseCode"] == 200) {
        LocalStorageManager.saveUser(result);
        return const Right(unit);
      }
      return Left(ServerFailure());
    } catch (e) {
      return Left(ServerFailure());
    }
  }
}
