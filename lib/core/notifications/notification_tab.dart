import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:in_app_notification/in_app_notification.dart';

import '../../main.dart';

class NotificationTab {
  static void showNotification(RemoteMessage remoteMessage) async {
    await InAppNotification.show(
        duration: const Duration(seconds: 5),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Container(
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.white.withOpacity(0.9),
              boxShadow: const [
                BoxShadow(color: Colors.black12, offset: Offset(0, 3))
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  remoteMessage.notification!.title!,
                  style: const TextStyle(fontWeight: FontWeight.w700),
                ),
                const SizedBox(height: 5),
                Text(remoteMessage.notification!.body!),
              ],
            ),
          ),
        ),
        context: navigatorGlobalKey.currentContext!);
  }
}
