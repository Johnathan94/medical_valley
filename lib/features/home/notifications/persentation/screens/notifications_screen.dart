import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:medical_valley/core/app_colors.dart';
import 'package:medical_valley/core/app_paddings.dart';
import 'package:medical_valley/core/app_styles.dart';
import 'package:medical_valley/features/home/notifications/persentation/widgets/notification_item_view.dart';

import '../../../../../core/strings/images.dart';
import '../../../../../core/widgets/custom_app_bar.dart';
import '../../data/models/notification_model.dart';
import 'package:grouped_list/grouped_list.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({Key? key}) : super(key: key);

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  List<NotificationModel> _notifications = [];

  @override
  initState() {
    getNotifications();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
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
     return GroupedListView<NotificationModel, String>(
       groupBy: (NotificationModel a){
         return a.date;
       },
       itemComparator: (item1, item2) =>
           item1.date.compareTo(item2.date),
       groupComparator: (value1, value2) => value2.compareTo(value1),
       order: GroupedListOrder.DESC,
       groupSeparatorBuilder: (String value) => Row(
         mainAxisAlignment: MainAxisAlignment.start,
         children: [
           Padding(
             padding: smallPaddingHV,
             child: Text(
               value,
               textAlign: TextAlign.center,
               style: AppStyles.baloo2FontWith700WeightAnd22Size.copyWith(color: blackColor),
             ),
           ),
         ],
       ),
       itemBuilder: (c, element) {
         return NotificationView(notificationModel: element);
       },
        elements: _notifications,
     );
  }

  buildNotificationItem(NotificationModel notification) {
    return Container();
  }
}
