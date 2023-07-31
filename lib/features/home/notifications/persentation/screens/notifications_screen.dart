import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get_it/get_it.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:medical_valley/core/app_colors.dart';
import 'package:medical_valley/core/app_paddings.dart';
import 'package:medical_valley/core/app_styles.dart';
import 'package:medical_valley/features/home/notifications/persentation/screens/bloc/notification_bloc.dart';
import 'package:medical_valley/features/home/notifications/persentation/widgets/notification_item_view.dart';

import '../../../../../core/widgets/custom_app_bar.dart';
import '../../data/models/notification_model.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({Key? key}) : super(key: key);

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  List<NotificationModel> _notifications = [];
  NotificationBloc notificationBloc = GetIt.instance<NotificationBloc>();
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
      body: BlocBuilder<NotificationBloc, NotificationState>(
          bloc: notificationBloc,
          builder: (context, state) {
            if (state is NotificationStateLoading) {
              return SizedBox(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  child: const Center(child: CircularProgressIndicator()));
            } else if (state is NotificationStateSuccess) {
              _notifications = state.notifications;
              return getNotificationsBody();
            } else {
              return SizedBox(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  child: Center(
                      child: Text(
                          AppLocalizations.of(context)!.something_went_wrong)));
            }
          }),
    );
  }

  buildMyAppBar() {
    return MyCustomAppBar(
      header: AppLocalizations.of(context)!.notifications,
      leadingIcon: Container(),
    );
  }

  void getNotifications() {
    notificationBloc.getNotifications();
  }

  Widget getNotificationsBody() {
    return _notifications.isEmpty
        ? Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            alignment: Alignment.center,
            child: Text(
              AppLocalizations.of(context)!.there_is_no_notifications,
              style: AppStyles.baloo2FontWith700WeightAnd15Size,
            ))
        : GroupedListView<NotificationModel, String>(
            groupBy: (NotificationModel a) {
              return a.userId.toString();
            },
            itemComparator: (item1, item2) =>
                item1.userId.toString().compareTo(item2.userId.toString()),
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
                    style: AppStyles.baloo2FontWith700WeightAnd22Size
                        .copyWith(color: blackColor),
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
