import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medical_valley/core/app_styles.dart';
import 'package:medical_valley/core/widgets/primary_button.dart';

import '../../../../core/app_colors.dart';
import '../../../../core/app_sizes.dart';
import '../../../../core/strings/images.dart';
import '../../../../core/widgets/no_internet_connection_widget.dart';

class WelcomePageScreen extends StatefulWidget {
  const WelcomePageScreen({Key? key}) : super(key: key);

  @override
  State<WelcomePageScreen> createState() => _WelcomePageScreenState();
}

class _WelcomePageScreenState extends State<WelcomePageScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        color: whiteColor,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              buildWelcomePageTitle(),
              buildWelcomePageIcon(),
              buildChooseYourLocationText(),
              buildUseMyCurrentLocationButton(context),
              buildSetItManually()
            ],
          ),
        ),
      ),
    );
  }

  buildWelcomePageTitle() {
    return Container(
      margin: const EdgeInsets.only(top: welcomePageTitleMarginTop),
      child: Text(
        AppLocalizations.of(context)!.welcome_to_medical_valley,
        style: AppStyles.baloo2FontWith500WeightAnd25Size,
      ),
    );
  }

  buildWelcomePageIcon() {
    return Image.asset(welcomeIcon);
  }

  buildChooseYourLocationText() {
    return SizedBox(
      width: chooseYourLocationWidth.w,
      child: Text(
        AppLocalizations.of(context)!.choose_your_location_and_start,
        textAlign: TextAlign.center,
        style: AppStyles.baloo2FontWith700WeightAnd25Size,
      ),
    );
  }

  buildUseMyCurrentLocationButton(BuildContext context) {
    return Container(
      margin: const EdgeInsetsDirectional.only(
          top: welcomePageButtonMarginTop,
          start: loginButtonMarginHorizontal,
          end: loginButtonMarginHorizontal),
      child: PrimaryButton(
        text: "",
        onPressed: () {
          navigateToHomeScreen();
        },
        isWidgetButton: true,
        body: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(locationIcon),
            Container(
              margin: const EdgeInsetsDirectional.only(
                  start: useMyCurrentLocationMarginStart),
              child: Text(
                AppLocalizations.of(context)!.use_my_current_location,
                style: AppStyles.baloo2FontWith400WeightAnd20Size,
              ),
            ),
          ],
        ),
      ),
    );
  }

  buildSetItManually() {
    return Container(
      margin: const EdgeInsets.only(top: setItManuallyMarginTop),
      child: Text(
        AppLocalizations.of(context)!.select_it_manually,
        style: AppStyles.baloo2FontWith400WeightAnd18Size,
      ),
    );
  }

  void navigateToHomeScreen() {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => const NoInternetConnectionWidget()));
  }
}
