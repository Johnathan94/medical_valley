import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medical_valley/core/app_sizes.dart';
import 'package:medical_valley/core/strings/images.dart';

import '../../../../core/app_colors.dart';
import '../../../auth/presentation/screens/login_screen.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Timer.periodic(const Duration(seconds: 5), (timer) {
      goToLoginScreen(context);
    });

    return Container(
      width: double.infinity,
      height: double.infinity,
      color: primaryColor,
      child: Center(
          child: Image.asset(
        appIcon,
        width: splashIconWidth.sw,
        height: splashIconHeight.sh,
      )),
    );
  }

  goToLoginScreen(BuildContext context) {
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const LoginScreen()));
  }
}
