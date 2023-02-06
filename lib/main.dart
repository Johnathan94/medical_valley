import 'dart:io';

import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medical_valley/core/app_sizes.dart';
import 'package:medical_valley/core/app_theme.dart';
import 'package:medical_valley/core/base_service/flavors.dart';
import 'package:medical_valley/core/medical_injection.dart';
import 'package:medical_valley/core/strings/urls.dart';
import 'package:medical_valley/features/splash/presentation/screens/splash_screen.dart';
class MyHttpOverrides extends HttpOverrides{
  @override
  HttpClient createHttpClient(SecurityContext? context){
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port)=> true;
  }
}
void main() {
  HttpOverrides.global = MyHttpOverrides();

  WidgetsFlutterBinding.ensureInitialized();
  FlavorManager.setCurrentFlavor(Flavor(Strings.baseUrl, Strings.v_1));
  configureDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DevicePreview(
        builder: (BuildContext context) {
          return ScreenUtilInit(
              designSize: const Size(screenWidth, screenHeight),
              minTextAdapt: true,
              splitScreenMode: true,
              builder: (context, child) {
                return MaterialApp(
                  theme: appTheme,
                  locale: const Locale("en"),
                  localizationsDelegates:
                      AppLocalizations.localizationsDelegates,
                  supportedLocales: AppLocalizations.supportedLocales,
                  onGenerateTitle: (context) =>
                      AppLocalizations.of(context)!.application_title,
                  debugShowCheckedModeBanner: false,
                  home: const SplashScreen(),
                );
              });
        },
        enabled: false);
  }
}
