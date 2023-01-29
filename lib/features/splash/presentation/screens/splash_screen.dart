import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medical_valley/core/app_initialized.dart';
import 'package:medical_valley/core/app_sizes.dart';
import 'package:medical_valley/core/strings/images.dart';
import 'package:medical_valley/features/offers/presentation/offers_screen.dart';

import '../../../../core/app_colors.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 1), () {
      AppInitializer.initializeAppWithContext(context);
      goToLoginScreen(context);
    });
    super.initState();
  }

  goToLoginScreen(BuildContext context) {
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const OffersScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.width,
      color: primaryColor,
      child: Center(
          child: Image.asset(
        appIcon,
        width: splashIconWidth.w,
        height: splashIconHeight.h,
      )),
    );
  }
}
