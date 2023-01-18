import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medical_valley/core/app_styles.dart';
import 'package:medical_valley/core/strings/images.dart';
import 'package:medical_valley/core/strings/messages.dart';

import '../../../../core/app_colors.dart';
import '../../../../core/app_sizes.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          getLoginBackground(),
          getLoginBody()
        ],
      ),
    );
  }

  getLoginBackground() {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: loginBackgroundHeight.sh,
      color: primaryColor,
      child: Center(
        child: Image.asset(
          appIcon,
          width: loginIconWidth.sw,
          height: loginIconHeight.sh,
        ),
      ),
    );
  }

  getLoginBody() {
    return Container(
      width: double.infinity,
      height: screenHeight.sh,
      decoration: BoxDecoration(
          color: whiteColor,
          borderRadius: BorderRadiusDirectional.only(
              topStart: Radius.circular(loginBodyRadius.sw))),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          buildLoginScreenTitle(),
        ],
      ),
    );
  }

  buildLoginScreenTitle() {
    return Center(
      child: Text(
        loginTitle,
        style: AppStyles.baloo2FontWith400WeightAnd32Size,
      ),
    );
  }
}
