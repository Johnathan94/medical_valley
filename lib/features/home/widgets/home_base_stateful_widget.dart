import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:medical_valley/core/app_colors.dart';
import 'package:medical_valley/core/app_styles.dart';
import 'package:medical_valley/core/strings/images.dart';

abstract class HomeBaseStatefulWidget extends StatefulWidget {
  const HomeBaseStatefulWidget({Key? key}) : super(key: key);
}

abstract class HomeBaseStatefulWidgetState
    extends State<HomeBaseStatefulWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: getBody(),
      bottomNavigationBar: buildBottomNavigationBar(),
    );
  }

  buildAppBar();

  getBody();

  buildBottomNavigationBar() {
    return BottomNavigationBar(
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
        ]);
  }
}
