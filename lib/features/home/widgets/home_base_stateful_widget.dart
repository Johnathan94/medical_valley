import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:medical_valley/core/app_colors.dart';
import 'package:medical_valley/core/app_styles.dart';
import 'package:medical_valley/core/strings/images.dart';
import 'package:medical_valley/features/home/history/presentation/history_screen.dart';
import 'package:medical_valley/features/home/more_screen/presentation/more_screen.dart';
import 'package:medical_valley/features/home/notifications/persentation/screens/notifications_screen.dart';
import 'package:rxdart/rxdart.dart';

import '../home_screen/persentation/screens/home_screen.dart';
import '../home_search_screen/persentation/screens/home_search_screen.dart';

class HomeBaseStatefulWidget extends StatefulWidget {
  const HomeBaseStatefulWidget({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => HomeBaseStatefulWidgetState();
}

class HomeBaseStatefulWidgetState extends State<HomeBaseStatefulWidget> {
  final BehaviorSubject<int> _index = BehaviorSubject();
  static BehaviorSubject<bool> _isSearchClicked = BehaviorSubject();

  @override
  initState() {
    _index.sink.add(0);
    _isSearchClicked.sink.add(false);
    super.initState();
  }

  @override
  dispose() {
    _index.stream.drain();
    _index.close();
    _isSearchClicked.stream.drain();
    _isSearchClicked.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: getBody(),
      bottomNavigationBar: buildBottomNavigationBar(),
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
        stream: _isSearchClicked,
        builder: (context, snapshot) {
          if (snapshot.hasData && (snapshot.data ?? false)) {
            return const HomeSearchScreen();
          } else {
            return const HomeScreen();
          }
        });
  }

  static searchIconClicked() {
    _isSearchClicked.sink.add(!_isSearchClicked.value);
  }
}
