import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:medical_valley/core/app_colors.dart';
import 'package:medical_valley/core/app_styles.dart';
import 'package:medical_valley/core/strings/images.dart';
import 'package:medical_valley/features/home/history/presentation/history_screen.dart';
import 'package:medical_valley/features/home/more_screen/presentation/more_screen.dart';
import 'package:medical_valley/features/home/notifications/persentation/screens/notifications_screen.dart';
import 'package:medical_valley/features/offers/presentation/offers_screen.dart';
import 'package:rxdart/rxdart.dart';

import '../../../core/notifications/notifications_helper.dart';
import '../../chat/on_boarding/peresentation/screens/chat_on_board_screen.dart';
import '../home_screen/persentation/screens/home_screen.dart';
import '../home_search_screen/persentation/screens/home_search_screen.dart';

class HomeBaseStatefulWidget extends StatefulWidget {
  const HomeBaseStatefulWidget({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => HomeBaseStatefulWidgetState();
}

final BehaviorSubject<bool> isSearchClicked = BehaviorSubject.seeded(false);

class HomeBaseStatefulWidgetState extends State<HomeBaseStatefulWidget> {
  final BehaviorSubject<int> _index = BehaviorSubject();

  @override
  initState() {
    _handleRequestNotification();

    _index.sink.add(0);
    super.initState();
  }

  @override
  dispose() {
    _index.stream.drain();
    _index.close();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
      body: getBody(),
      bottomNavigationBar: buildBottomNavigationBar(),
      //floatingActionButton: getFloatingButton(),
    );
  }

  getBody() {
    return StreamBuilder<int>(
      stream: _index,
      builder: (context, snapshot) {
        if (snapshot.data == 0) {
          return getHomeScreen();
        } else if (snapshot.data == 1) {
          return const NotificationsScreen();
        } else if (snapshot.data == 2) {
          return const HistoryScreen();
        } else if (snapshot.data == 3) {
          return const MoreScreen();
        }
        return Container(
          color: Colors.green,
        );
      },
    );
  }

  buildBottomNavigationBar() {
    return StreamBuilder<int>(
        stream: _index,
        builder: (context, snapshot) {
          return BottomNavigationBar(
            onTap: (newIndex) {
              _index.sink.add(newIndex);
            },
            currentIndex: snapshot.data ?? 0,
            type: BottomNavigationBarType.fixed,
            selectedLabelStyle: AppStyles.baloo2FontWith600WeightAnd18Size,
            showUnselectedLabels: false,
            items: [
              BottomNavigationBarItem(
                  icon: Image.asset(homeIconDeactivated),
                  activeIcon: Image.asset(homeIconActive),
                  backgroundColor: whiteColor,
                  label: AppLocalizations.of(context)!.home),
              BottomNavigationBarItem(
                  icon: Image.asset(notificationIconDeactivated),
                  activeIcon: Image.asset(notificationIconActive),
                  backgroundColor: whiteColor,
                  label: AppLocalizations.of(context)!.notifications),
              BottomNavigationBarItem(
                  icon: Image.asset(historyIconDeactivated),
                  activeIcon: Image.asset(historyIconActive),
                  backgroundColor: whiteColor,
                  label: AppLocalizations.of(context)!.history),
              BottomNavigationBarItem(
                  icon: Image.asset(menuIconDeactivated),
                  activeIcon: Image.asset(menuIconActive),
                  backgroundColor: whiteColor,
                  label: AppLocalizations.of(context)!.more),
            ],
          );
        });
  }

  getHomeScreen() {
    return StreamBuilder<bool>(
        stream: isSearchClicked,
        builder: (context, snapshot) {
          if (snapshot.hasData && (snapshot.data ?? false)) {
            return HomeSearchScreen(
              isBackPressed: () {
                isSearchClicked.sink.add(false);
              },
            );
          } else {
            return const HomeScreen();
          }
        });
  }

  static searchIconClicked() {
    isSearchClicked.sink.add(!isSearchClicked.value);
  }

  getFloatingButton() {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => const ChatOnBoardingScreen()));
      },
      child: Container(
          width: 90.w,
          height: 129.h,
          decoration: const BoxDecoration(
              color: whiteColor,
              borderRadius: BorderRadius.all(Radius.circular(12)),
              boxShadow: [BoxShadow(color: shadowColor, blurRadius: 8)]),
          child: SvgPicture.asset(
            floatingIcon,
            fit: BoxFit.cover,
          )),
    );
  }

  void _handleRequestNotification() {
    FirebaseMessaging.onMessage.listen((event) {
      _backgroundHandler(event);
    });
    FirebaseMessaging.onMessageOpenedApp.listen((event) {
      _backgroundHandler(event);
    });
    // FirebaseMessaging.onBackgroundMessage(_backgroundHandler);
  }

  Future<void> _backgroundHandler(RemoteMessage event) async {
    final notificationActionId =
        NotificationHelper.getNotificationActionId(event);
    final requestId = int.parse(event.data['RequestId'].toString());
    _navigate(notificationActionId, requestId);
  }

  void _navigate(int notificationActionId, int requestId) {
    switch (notificationActionId - 1) {
      case 1:
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => OffersScreen(requestId: requestId),
        ));
        return;
      case 2:
        _index.sink.add(2);
        return;
    }
  }
}
