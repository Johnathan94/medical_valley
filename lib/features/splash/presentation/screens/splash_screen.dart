import 'dart:async';

import 'package:flutter/material.dart';
import 'package:medical_valley/core/app_initialized.dart';
import 'package:medical_valley/core/app_sizes.dart';
import 'package:medical_valley/core/strings/images.dart';

import '../../../../core/app_colors.dart';
import '../../../auth/login/presentation/screens/login_screen.dart';

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
        MaterialPageRoute(builder: (context) => const LoginScreen()));
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
        width: splashIconWidth,
        height: splashIconHeight,
      )),
    );
  }
}
