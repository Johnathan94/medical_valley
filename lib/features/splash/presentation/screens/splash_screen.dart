import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it/get_it.dart';
import 'package:medical_valley/core/app_initialized.dart';
import 'package:medical_valley/core/app_sizes.dart';
import 'package:medical_valley/core/dialogs/loading_dialog.dart';
import 'package:medical_valley/core/shared_pref/shared_pref.dart';
import 'package:medical_valley/core/strings/images.dart';
import 'package:medical_valley/features/auth/login/presentation/screens/login_screen.dart';
import 'package:medical_valley/features/splash/presentation/screens/no_location_service_screen.dart';
import 'package:medical_valley/features/welcome_page/splash_bloc.dart';
import 'package:network_logger/network_logger.dart';

import '../../../../core/app_colors.dart';
import '../../../home/widgets/home_base_stateful_widget.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  SplashBloc splashBloc = GetIt.instance<SplashBloc>();
  @override
  void initState() {
    NetworkLoggerOverlay.attachTo(
      context,
    );
    Future.delayed(const Duration(seconds: 5), () async {});
    super.initState();
  }

  @override
  didChangeDependencies() async {
    await AppInitializer.initializeAppWithContext(context);
    splashBloc.getLocation();
    super.didChangeDependencies();
  }

  goToLoginScreen(BuildContext context) {
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const LoginScreen()));
  }

  goToHomeScreen(BuildContext context) {
    Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) => const HomeBaseStatefulWidget()));
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<SplashBloc, SplashState>(
      bloc: splashBloc,
      listener: (context, state) {
        if (state is ErrorSplashState) {
          LoadingDialogs.hideLoadingDialog();
          Navigator.of(context).push(MaterialPageRoute(
              builder: (c) => NoLocationServiceScreen(
                    onRetry: () {
                      splashBloc.getLocation();
                    },
                  )));
        } else if (state is SuccessSplashState) {
          LoadingDialogs.hideLoadingDialog();
          Future.delayed(const Duration(seconds: 2), () {
            if (LocalStorageManager.getUser() == null) {
              goToLoginScreen(context);
            } else {
              goToHomeScreen(context);
            }
          });
        } else {
          LoadingDialogs.showLoadingDialog(context);
        }
      },
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.width,
        color: primaryColor,
        child: Center(
            child: Image.asset(
          appIcon,
          width: splashIconWidth.w,
          height: splashIconHeight.h,
        )),
      ),
    );
  }
}
