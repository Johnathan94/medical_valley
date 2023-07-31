import 'package:dio/dio.dart';
import 'package:medical_valley/core/shared_pref/shared_pref.dart';
import 'package:medical_valley/features/auth/phone_verification/data/model/otp_response_model.dart';
import 'package:medical_valley/features/welcome_page/data/update_location_request.dart';

class UpdateUserLocationClient {
  Dio dio;

  UpdateUserLocationClient(this.dio);

  updateLocation(UpdateLocationRequest model) async {
    var userDate = UserDate.fromJson(LocalStorageManager.getUser()!);
    model.id = userDate.id;
    Response response = await dio.put(
        "${dio.options.baseUrl}/User/UpdateUserLocation",
        data: model.toJson());
    return response.data;
  }
}
