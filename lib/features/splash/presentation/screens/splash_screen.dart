import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medical_valley/core/app_sizes.dart';
import 'package:medical_valley/core/strings/images.dart';
import 'package:medical_valley/features/register/presentation/registeration_screen.dart';

import '../../../../core/app_colors.dart';
import '../../../auth/presentation/screens/login_screen.dart';
class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Future.delayed( const Duration(seconds: 5), () {
      goToLoginScreen(context);
    });
    super.initState();
  }

  goToLoginScreen(BuildContext context) {
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const RegistrationScreen()));
  }
  @override
  Widget build(BuildContext context) {
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
}


