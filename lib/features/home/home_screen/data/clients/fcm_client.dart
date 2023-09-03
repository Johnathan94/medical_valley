import 'package:dio/dio.dart';
import '../../../../../core/shared_pref/shared_pref.dart';

class FcmClient {
  Dio dio;

  FcmClient(this.dio);

  updateFcmToken(String fcmToken, String deviceId) async {
    final authToken = await LocalStorageManager.getToken();
    await dio.post("${dio.options.baseUrl}/Alpha/Notifications/AddFCMToken",
        data: {
          'deviceID': deviceId,
          'fcmToken': fcmToken,
        },
        options: Options(
          headers: {'Authorization': 'Bearer $authToken'},
        ));
  }
}
