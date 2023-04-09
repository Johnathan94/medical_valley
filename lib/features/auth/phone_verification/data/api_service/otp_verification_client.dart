
import 'package:dio/dio.dart';

import '../../../../../core/base_service/dio_manager.dart';
import '../../../../../core/strings/urls.dart';
import '../models/request/otp_request_model.dart';

class OtpVerificationClient {

  Dio dio = DioManager.getDio();

  OtpVerificationClient();

  sendCode(OtpRequestModel otpRequestModel) async {
    Response response = await dio.post(
        "${Strings.baseUrl}v1/User/VerifyUserOtp?mobile=${otpRequestModel.phoneNumber}&otp=${otpRequestModel.otpCode}",
        data: otpRequestModel.toJson());
    return response.data;
  }
}