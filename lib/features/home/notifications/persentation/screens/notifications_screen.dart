import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../../core/strings/images.dart';
import '../../../../../core/widgets/custom_app_bar.dart';
import '../../data/models/notification_model.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({Key? key}) : super(key: key);

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  List<NotificationModel> _notifications = [];
  Map<String, String> _notificationsMap = {};

  @override
  initState() {
    getNotifications();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildMyAppBar(),
      body: getNotificationsBody(),
    );
  }

  buildMyAppBar() {
    return MyCustomAppBar(
      header: AppLocalizations.of(context)!.notifications,
      leadingIcon: Container(),
    );
  }

  void getNotifications() {
    _notifications.add(NotificationModel(
        1,
        "Congratulations!",
        "This text is a test script to facilitate the user experience service",
        "3 min",
        "yesterday",
        settingIcon));
    _notifications.add(NotificationModel(
        1,
        "Congratulations!",
        "This text is a test script to facilitate the user experience service",
        "30 min",
        "yesterday",
        settingIcon));
    _notifications.add(NotificationModel(
        1,
        "Congratulations!",
        "This text is a test script to facilitate the user experience service",
        "6:12 AM",
        "yesterday",
        settingIcon));
    _notifications.add(NotificationModel(
        1,
        "Congratulations!",
        "This text is a test script to facilitate the user experience service",
        "6:12 PM",
        "September",
        settingIcon));
    _notifications.add(NotificationModel(
        1,
        "Congratulations!",
        "This text is a test script to facilitate the user experience service",
        "6:12 PM",
        "September",
        settingIcon));
    _notifications.add(NotificationModel(
        1,
        "Congratulations!",
        "This text is a test script to facilitate the user experience service",
        "6:12 PM",
        "September",
        settingIcon));
    _notifications.add(NotificationModel(
        1,
        "Congratulations!",
        "This text is a test script to facilitate the user experience service",
        "6:12 PM",
        "September",
        settingIcon));
  }

  getNotificationsBody() {
    return Container();
    // return GroupedListView<dynamic, String>(
    //     elements: _notifications,
    //     ;
  }

  buildNotificationItem(NotificationModel notification) {
    return Container();
  }
}
