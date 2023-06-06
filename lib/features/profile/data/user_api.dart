import 'package:dio/dio.dart';
import 'package:medical_valley/core/shared_pref/shared_pref.dart';
import 'package:medical_valley/features/auth/phone_verification/data/model/otp_response_model.dart';
import 'package:medical_valley/features/profile/data/edit_user_request.dart';

class UserClient {
  Dio dio;

  UserClient(this.dio);

  getUserData() async {
    var userDate = UserDate.fromJson(LocalStorageManager.getUser()!);
    Response response = await dio.get(
      "${dio.options.baseUrl}/User/GetUserById?userId=${userDate.id}",
    );
    return response.data;
  }

  updateUserData(UpdateUserRequest request) async {
    var formData = FormData.fromMap({
      'name': 'wendux',
      'age': 25,
      'file': await MultipartFile.fromFile('./text.txt', filename: 'upload.txt')
    });
    Response response = await dio.put("${dio.options.baseUrl}/User/EditProfile",
        data: formData);
    return response.data;
  }
}
