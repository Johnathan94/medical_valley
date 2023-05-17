import 'package:dio/dio.dart';
import 'package:medical_valley/core/shared_pref/shared_pref.dart';
import 'package:medical_valley/features/auth/phone_verification/data/model/otp_response_model.dart';
import 'package:medical_valley/features/offers/presentation/data/model/negotiate_model.dart';

class NegotiateClient {
  Dio dio;

  NegotiateClient(this.dio);

  negotiate(NegotiateModel model) async {
    Response response = await dio
        .post("${dio.options.baseUrl}/Request/Negotiate", data: model.toJson());
    return response.data;
  }

  verifyRequest(int offerId) async {
    UserDate user = UserDate.fromJson(LocalStorageManager.getUser()!);
    Response response = await dio.put(
      "${dio.options.baseUrl}/Request/ConfirmOffer?userId=${user.id}&offerId=$offerId",
    );
    return response.data;
  }
}
