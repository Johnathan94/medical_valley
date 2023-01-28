import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medical_valley/core/app_colors.dart';
import 'package:medical_valley/core/app_styles.dart';

import '../../../../../core/app_sizes.dart';
import '../../../../../core/widgets/app_bar_with_null_background.dart';
import '../../../../welcome_page/presentation/screens/welcome_page_screen.dart';

class PhoneVerificationScreen extends StatefulWidget {
  const PhoneVerificationScreen({Key? key}) : super(key: key);

  @override
  State<PhoneVerificationScreen> createState() =>
      _PhoneVerificationScreenState();
}

class _PhoneVerificationScreenState extends State<PhoneVerificationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWithoutBackground(
          header: AppLocalizations.of(context)!.phone_verification,
          leadingIcon: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: const Icon(
              Icons.arrow_back_ios,
              color: blackColor,
            ),
          )),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        color: whiteColor,
        child: Center(
          child: SizedBox(
            height: phoneVerificationBodyHeight.h,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                buildPhoneVerificationDesc(),
                buildOtpField(),
                buildConfirmButton(context)
              ],
            ),
          ),
        ),
      ),
    );
  }

  buildPhoneVerificationDesc() {
    return Text(
      AppLocalizations.of(context)!.enter_you_otp,
      style: AppStyles.baloo2FontWith400WeightAnd25Size,
    );
  }

  buildOtpField() {
    return OtpTextField(
      fieldWidth: otpFieldWidth.w,
      numberOfFields: otpFieldNumber,
      borderWidth: otpFieldBorderWidth.w,
      enabledBorderColor: greyWith80Percentage,
      focusedBorderColor: primaryColor,
      borderRadius:
          const BorderRadius.all(Radius.circular(otpFieldBorderRadius)),
      showFieldAsBox: true,
    );
  }

  buildConfirmButton(BuildContext context) {
    return Container(
      margin: const EdgeInsetsDirectional.only(
          start: loginButtonMarginHorizontal, end: loginButtonMarginHorizontal),
      child: TextButton(
          style: ButtonStyle(
              textStyle: MaterialStateProperty.all(
                  AppStyles.baloo2FontWith400WeightAnd22Size),
              backgroundColor: MaterialStateProperty.all(primaryColor),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(loginButtonRadius),
              ))),
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => const WelcomePageScreen()));
          },
          child: Center(
            child: Text(
              AppLocalizations.of(context)!.continue_text,
              style: AppStyles.baloo2FontWith400WeightAnd22Size,
            ),
          )),
    );
  }
}
