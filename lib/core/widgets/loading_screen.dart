import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:medical_valley/core/app_colors.dart';
import 'package:medical_valley/core/app_styles.dart';
import 'package:medical_valley/core/widgets/primary_button.dart';

class LoadingScreen extends StatelessWidget {
  const LoadingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        color: primaryColor,
        child: Column(
          children: [
            Stack(
              children: const [
                SpinKitRipple(
                  color: whiteColor,
                  borderWidth: 20.0,
                  size: 500,
                ),
              ],
            ),
            Padding(
              padding:
                  EdgeInsetsDirectional.only(top: 60.h, start: 44.w, end: 44.w),
              child: Text(
                AppLocalizations.of(context)!.loading_screen_text,
                style: AppStyles.baloo2FontWith700WeightAnd28Size,
              ),
            ),
            Padding(
              padding: EdgeInsetsDirectional.only(
                  top: 100.h, start: 35.w, end: 35.w),
              child: PrimaryButton(
                text: AppLocalizations.of(context)!.cancel,
                backgroundColor: secondaryColor,
                onPressed: () {
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
