import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import '../data/clients/fcm_client.dart';

class UpdateFcmUseCase {
  FcmClient client;

  UpdateFcmUseCase(this.client);

  Future<void> updateFcmToken() async {
    final DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    final fcmToken = await FirebaseMessaging.instance.getToken();
    String deviceId = "";
    if (Platform.isAndroid) {
      await deviceInfo.androidInfo.then((value) => deviceId = value.id);
    } else {
      await deviceInfo.iosInfo
          .then((value) => deviceId = value.identifierForVendor!);
    }
    await client.updateFcmToken(fcmToken ?? "", deviceId);
  }
}
