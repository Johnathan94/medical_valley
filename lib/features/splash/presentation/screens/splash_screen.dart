import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medical_valley/core/app_initialized.dart';
import 'package:medical_valley/core/app_sizes.dart';
import 'package:medical_valley/core/shared_pref/shared_pref.dart';
import 'package:medical_valley/core/strings/images.dart';
import 'package:medical_valley/features/auth/login/presentation/screens/login_screen.dart';
import 'package:medical_valley/features/home/widgets/home_base_stateful_widget.dart';

import '../../../../core/app_colors.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 1), () async{
      await AppInitializer.initializeAppWithContext(context);
      if(LocalStorageManager.getUser() == null){
        goToLoginScreen(context);
      }else {
        goToHomeScreen(context);
      }
    });
    super.initState();
  }

  goToLoginScreen(BuildContext context) {
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const LoginScreen()));
  }goToHomeScreen(BuildContext context) {
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const HomeBaseStatefulWidget()));
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
