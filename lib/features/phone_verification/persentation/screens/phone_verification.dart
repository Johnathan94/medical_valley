import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:medical_valley/core/app_colors.dart';
import 'package:medical_valley/core/app_styles.dart';

import '../../../../core/app_sizes.dart';
import '../../../../core/strings/messages.dart';
import '../../../../core/widgets/app_bar_with_null_background.dart';

class PhoneVerificationScreen extends StatelessWidget {
  const PhoneVerificationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWithNullBackground(
          header: phoneVerificationText,
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
            height: phoneVerificationBodyHeight,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                buildPhoneVerificationDesc(),
                buildOtpField(),
                buildConfirmButton()
              ],
            ),
          ),
        ),
      ),
    );
  }

  buildPhoneVerificationDesc() {
    return Text(
      phoneVerificationDesc,
      style: AppStyles.baloo2FontWith400WeightAnd25Size,
    );
  }

  buildOtpField() {
    return OtpTextField(
      fieldWidth: otpFieldWidth,
      numberOfFields: otpFieldNumber,
      borderWidth: otpFieldBorderWidth,
      enabledBorderColor: greyWith80Percentage,
      focusedBorderColor: primaryColor,
      borderRadius:
          const BorderRadius.all(Radius.circular(otpFieldBorderRadius)),
      showFieldAsBox: true,
    );
  }

  buildConfirmButton() {
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
          onPressed: () {},
          child: Center(
            child: Text(
              continueText,
              style: AppStyles.baloo2FontWith400WeightAnd22Size,
            ),
          )),
    );
  }
}
