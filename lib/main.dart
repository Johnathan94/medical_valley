import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medical_valley/core/app_sizes.dart';
import 'package:medical_valley/core/app_theme.dart';
import 'package:medical_valley/features/splash/presentation/screens/splash_screen.dart';

import 'core/strings/messages.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(screenWidth, screenHeight),
        builder: (context, child) {
          return MaterialApp(
            title: applicationTitle,
            theme: appTheme,
            debugShowCheckedModeBanner: false,
            home: const SplashScreen(),
          );
        });
  }
}
