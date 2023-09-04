import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import '../../../../core/shared_pref/shared_pref.dart';
import '../data/clients/fcm_client.dart';

enum UserIdentityType { Admin, Provider, PublicUser }

enum DeviceType { Android, IOS, WEB }

class UpdateFcmUseCase {
  FcmClient client;

  UpdateFcmUseCase(this.client);

  Future<void> updateFcmToken() async {
    final DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    final fcmToken = await FirebaseMessaging.instance.getToken();
    String deviceId = "";
    int deviceType = 0;
    final userId = LocalStorageManager.getUser()!['id'];
    if (Platform.isAndroid) {
      deviceType = DeviceType.Android.index;
      await deviceInfo.androidInfo.then((value) => deviceId = value.id);
    } else {
      deviceType = DeviceType.IOS.index;
      await deviceInfo.iosInfo
          .then((value) => deviceId = value.identifierForVendor!);
    }
    await client.updateFcmToken(
      fcmToken: fcmToken ?? "",
      deviceId: deviceId,
      userIdentityType: UserIdentityType.PublicUser.index,
      userId: userId,
      deviceType: deviceType,
    );
  }
}
