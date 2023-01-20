import 'package:flutter/material.dart';
import 'package:medical_valley/core/app_colors.dart';
import 'package:medical_valley/core/app_styles.dart';

class AppBarWithoutBackground extends AppBar {
  String header;
  Widget leadingIcon;
  AppBarWithoutBackground(
      {required this.header, required this.leadingIcon, Key? key})
      : super(
          key: key,
          title: Text(
            header,
            style: AppStyles.baloo2FontWith700WeightAnd22Size,
          ),
          leading: leadingIcon,
          elevation: 0,
          backgroundColor: whiteColor,
        );
}
