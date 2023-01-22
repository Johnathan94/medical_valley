import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medical_valley/core/app_sizes.dart';
import 'package:medical_valley/core/app_theme.dart';
import 'package:medical_valley/features/splash/presentation/screens/splash_screen.dart';

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
            theme: appTheme,
            locale: const Locale("en"),
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            onGenerateTitle: (context) =>
                AppLocalizations.of(context)!.application_title,
            debugShowCheckedModeBanner: false,
            home: const SplashScreen(),
          );
        });
  }
}
