import 'package:flutter/material.dart';
import 'package:medical_valley/core/app_styles.dart';

import '../../../../core/app_colors.dart';
import '../../../../core/app_sizes.dart';
import '../../../../core/strings/images.dart';
import '../../../../core/strings/messages.dart';

class WelcomePageScreen extends StatelessWidget {
  const WelcomePageScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        color: whiteColor,
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
    );
  }

  buildWelcomePageTitle() {
    return Container(
      margin: const EdgeInsets.only(top: welcomePageTitleMarginTop),
      child: Text(
        welcomePageTitle,
        style: AppStyles.baloo2FontWith500WeightAnd25Size,
      ),
    );
  }

  buildWelcomePageIcon() {
    return Image.asset(welcomeIcon);
  }

  buildChooseYourLocationText() {
    return SizedBox(
      width: chooseYourLocationWidth,
      child: Text(
        chooseYourLocationText,
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
      child: TextButton(
          style: ButtonStyle(
              textStyle: MaterialStateProperty.all(
                  AppStyles.baloo2FontWith400WeightAnd22Size),
              backgroundColor: MaterialStateProperty.all(primaryColor),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(loginButtonRadius),
              ))),
          onPressed: () {},
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(locationIcon),
                Container(
                  margin: const EdgeInsetsDirectional.only(
                      start: useMyCurrentLocationMarginStart),
                  child: Text(
                    useMyCurrentLocationText,
                    style: AppStyles.baloo2FontWith400WeightAnd20Size,
                  ),
                ),
              ],
            ),
          )),
    );
  }

  buildSetItManually() {
    return Container(
      margin: const EdgeInsets.only(top: setItManuallyMarginTop),
      child: Text(
        setItManuallyText,
        style: AppStyles.baloo2FontWith400WeightAnd18Size,
      ),
    );
  }
}
