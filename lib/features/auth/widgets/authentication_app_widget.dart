import 'package:flutter/material.dart';

import '../../../../../core/app_colors.dart';
import '../../../../../core/app_sizes.dart';

class AuthenticationAppWidget extends StatelessWidget {
  final String appIcon;
  const AuthenticationAppWidget({Key? key, required this.appIcon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: loginAnotherAppsWidth,
      height: loginAnotherAppsHeight,
      alignment: AlignmentDirectional.center,
      margin: const EdgeInsets.only(top: loginAnotherAppsMarginTop),
      decoration: const BoxDecoration(
          color: whiteColor,
          borderRadius:
              BorderRadius.all(Radius.circular(loginAnotherAppsRadius)),
          boxShadow: [
            BoxShadow(
              blurRadius: 9,
              spreadRadius: -1,
              color: shadowColor,
            )
          ]),
      child: Image.asset(
        appIcon,
        width: loginAnotherAppsIconWidth,
        height: loginAnotherAppsIconHeight,
      ),
    );
  }
}
