import 'package:firebase_messaging/firebase_messaging.dart';

enum NotificationActions {
  AddBooking,
  AddOffer,
  AddNegotiate,
  VerifyRequest,
  MakeInvoice,
}

class NotificationHelper {
  static int getNotificationActionId(RemoteMessage remoteMessage) {
    final notificationActionId =
        remoteMessage.data['NotificationActionId'] ?? -2;

    return int.parse(notificationActionId.toString());
  }
}
