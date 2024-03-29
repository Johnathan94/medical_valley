import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medical_valley/core/strings/images.dart';

import '../app_colors.dart';
import '../app_sizes.dart';
import '../app_styles.dart';

class MyCustomAppBar extends AppBar {
  final String header;
  final Widget leadingIcon;
  final bool isActionButtonShown;
  MyCustomAppBar(
      {required this.header,
      required this.leadingIcon,
      this.isActionButtonShown = true,
      Key? key})
      : super(
          key: key,
          title: Text(
            header,
            style: AppStyles.baloo2FontWith500WeightAnd22Size
                .copyWith(color: Colors.white, fontWeight: FontWeight.w800),
          ),
          leading: leadingIcon,
          elevation: 0,
          backgroundColor: primaryColor,
          centerTitle: false,
          actions: isActionButtonShown
              ? [
                  Image.asset(
                    transparentAppIcon,
                    width: 80,
                    height: 80,
                  )
                ]
              : [],
          titleSpacing: -10,
          toolbarHeight: customAppBarHeight.h,
        );
}
