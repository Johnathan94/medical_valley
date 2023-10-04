import 'dart:io';

import 'package:device_preview/device_preview.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medical_valley/core/app_sizes.dart';
import 'package:medical_valley/core/app_theme.dart';
import 'package:medical_valley/core/base_service/flavors.dart';
import 'package:medical_valley/core/medical_injection.dart';
import 'package:medical_valley/core/shared_pref/shared_pref.dart';
import 'package:medical_valley/core/strings/urls.dart';
import 'package:medical_valley/core/widgets/change_language_screen/peresentation/blocks/chnage_language_block.dart';
import 'package:medical_valley/core/widgets/change_language_screen/peresentation/blocks/language_state.dart';
import 'package:medical_valley/features/splash/presentation/screens/splash_screen.dart';

import 'core/notifications/notification_tab.dart';
import 'firebase_options.dart';

LanguageBloc languageBloc = LanguageBloc();

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await FirebaseMessaging.instance.requestPermission(
    alert: true,
    badge: true,
    sound: true,
  );
  FirebaseMessaging.onMessage.listen((event) {
    if (kDebugMode) {
      print('hi message user');
    }
    if (kDebugMode) {
      print(event.notification?.title);
    }
    if (kDebugMode) {
      print(event.notification?.body);
    }
    if (kDebugMode) {
      print(event.notification?.body);
    }
    if (kDebugMode) {
      print(event.data);
    }
    NotificationTab.showNotification(event);
  });
  FirebaseMessaging.onMessageOpenedApp.listen((event) {
    if (kDebugMode) {
      print('hi message');
    }
    if (kDebugMode) {
      print(event.notification?.title);
    }
    if (kDebugMode) {
      print(event.notification?.body);
    }
    if (kDebugMode) {
      print(event.notification?.body);
    }
    if (kDebugMode) {
      print(event.data);
    }
  });
  HttpOverrides.global = MyHttpOverrides();
  WidgetsFlutterBinding.ensureInitialized();
  FlavorManager.setCurrentFlavor(Flavor(Strings.baseUrl, Strings.v_1));
  configureDependencies();
  await LocalStorageManager.initialize();
  String currentLanguage = LocalStorageManager.getCurrentLanguage();
  runApp(MyApp(currentLanguage: currentLanguage));
}

final GlobalKey<NavigatorState> navigatorGlobalKey =
    GlobalKey<NavigatorState>();

class MyApp extends StatelessWidget {
  final String currentLanguage;
  const MyApp({required this.currentLanguage, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DevicePreview(
        builder: (BuildContext context) {
          return BlocBuilder<LanguageBloc, LanguageState>(
              bloc: languageBloc,
              builder: (context, state) {
                return ScreenUtilInit(
                    designSize: const Size(screenWidth, screenHeight),
                    minTextAdapt: true,
                    splitScreenMode: true,
                    builder: (context, child) {
                      return MaterialApp(
                        navigatorKey: navigatorGlobalKey,
                        theme: appTheme,
                        locale: state.locale ??
                            (currentLanguage.isNotEmpty
                                ? Locale(currentLanguage)
                                : const Locale("en")),
                        localizationsDelegates:
                            AppLocalizations.localizationsDelegates,
                        supportedLocales: AppLocalizations.supportedLocales,
                        onGenerateTitle: (context) =>
                            AppLocalizations.of(context)!.application_title,
                        debugShowCheckedModeBanner: false,
                        home: const SplashScreen(),
                      );
                    });
              });
        },
        enabled: false);
  }
}
