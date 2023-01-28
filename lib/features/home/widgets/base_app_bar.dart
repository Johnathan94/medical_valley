import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medical_valley/core/strings/images.dart';

import '../../../core/app_colors.dart';
import '../../../core/app_sizes.dart';
import '../../../core/app_styles.dart';

class CustomHeaderAppBar extends AppBar {
  final String goodMorningText;
  final String? searchHint;
  CustomHeaderAppBar({this.searchHint, required this.goodMorningText, Key? key})
      : super(
            key: key,
            elevation: 0,
            leading: Container(),
            centerTitle: false,
            titleSpacing: appBarTitleNegativeMargin,
            title: Column(
              children: [
                Row(
                  children: [
                    Image.asset(
                      appIcon,
                      width: appBarIconWidth.w,
                      height: appBarIconHeight.h,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              goodMorningText,
                              style: AppStyles.baloo2FontWith700WeightAnd17Size,
                            ),
                            Image.asset(
                              handIcon,
                            )
                          ],
                        ),
                        Text(
                          "Hossam Saeed",
                          style: AppStyles.baloo2FontWith400WeightAnd22Size,
                        ),
                      ],
                    )
                  ],
                ),
              ],
            ),
            backgroundColor: primaryColor,
            toolbarHeight: 50.h);
}
