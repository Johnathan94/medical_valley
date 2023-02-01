import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:medical_valley/core/app_colors.dart';
import 'package:medical_valley/core/app_styles.dart';
import 'package:medical_valley/core/widgets/primary_button.dart';
import 'package:medical_valley/features/payment/persentation/screens/payment_screen.dart';

import '../../../../../core/strings/images.dart';

class ChatOnBoardingScreen extends StatelessWidget {
  const ChatOnBoardingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(top: 50.h),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        color: whiteColor,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            buildScreenImage(),
            buildScreenDescription(context),
            buildScreenSeparator(),
            buildNextButton(context),
          ],
        ),
      ),
    );
  }

  buildScreenImage() {
    return SvgPicture.asset(chatOnBoardingIcon);
  }

  buildScreenDescription(BuildContext context) {
    return Padding(
      padding: EdgeInsetsDirectional.only(top: 40.h, start: 27.w, end: 27.w),
      child: Text(
        AppLocalizations.of(context)!.chat_on_boarding_desc,
        style: AppStyles.baloo2FontWith700WeightAnd40Size,
        textAlign: TextAlign.center,
      ),
    );
  }

  buildScreenSeparator() {
    return Container(
      margin: EdgeInsets.only(top: 60),
      alignment: AlignmentDirectional.center,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 71.w,
            height: 18.h,
            decoration: const BoxDecoration(
                color: primaryColor,
                borderRadius: BorderRadius.all(Radius.circular(45))),
          ),
          Container(
            width: 18.w,
            height: 18.h,
            decoration: const BoxDecoration(
                color: primaryColorLight, shape: BoxShape.circle),
          )
        ],
      ),
    );
  }

  buildNextButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(37.0),
      child: PrimaryButton(
          onPressed: () {
            Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => const PaymentScreen()));
          },
          text: AppLocalizations.of(context)!.next),
    );
  }
}
