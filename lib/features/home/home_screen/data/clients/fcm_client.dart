import 'package:dio/dio.dart';
import '../../../../../core/shared_pref/shared_pref.dart';

class FcmClient {
  Dio dio;

  FcmClient(this.dio);

  updateFcmToken({
    required String fcmToken,
    required String deviceId,
    required int deviceType,
    required int userIdentityType,
    required dynamic userId,
  }) async {
    final authToken = await LocalStorageManager.getToken();
    await dio.post("${dio.options.baseUrl}/Alpha/Notifications/AddFCMToken",
        data: {
          'deviceID': deviceId,
          'fcmToken': fcmToken,
          'userID': userId,
          'userIdentityType': userIdentityType,
          'deviceType': deviceType,
        },
        options: Options(
          headers: {'Authorization': 'Bearer $authToken'},
        ));
  }
}
