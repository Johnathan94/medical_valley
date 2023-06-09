import 'package:dio/dio.dart';
import 'package:medical_valley/core/base_service/dio_manager.dart';
import 'package:medical_valley/core/shared_pref/shared_pref.dart';
import 'package:medical_valley/features/auth/phone_verification/data/model/otp_response_model.dart';
import 'package:medical_valley/features/home/home_screen/data/book_request_model.dart';

class BookRequestClient {
  Dio dio = DioManager.getDio();

  BookRequestClient();

  sendRequest(BookRequestModel requestModel) async {
    UserDate currentUser = UserDate.fromJson(LocalStorageManager.getUser()!);
    requestModel.userId = currentUser.id;
    Response response = await dio.post(
        "${dio.options.baseUrl}/Request/SendRequest",
        data: requestModel.toJson());
    return response.data;
  }

  getRequests() async {
    UserDate currentUser = UserDate.fromJson(LocalStorageManager.getUser()!);

    Response response = await dio.get(
        "${dio.options.baseUrl}/Request/UserRequests?UserId=${currentUser.id}");
    return response.data;
  }
}
