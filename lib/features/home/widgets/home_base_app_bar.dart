import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medical_valley/core/strings/images.dart';

import '../../../core/app_colors.dart';
import '../../../core/app_sizes.dart';
import '../../../core/app_styles.dart';
import '../../../core/widgets/custom_search_field.dart';

class CustomHomeAppBar extends AppBar {
  final bool isSearchableAppBar;
  final bool isTwoLineTitle;
  final String goodMorningText;
  final String? searchHint;
  final Widget leadingIcon;
  CustomHomeAppBar(
      {this.searchHint,
      required this.isSearchableAppBar,
      required this.goodMorningText,
      required this.leadingIcon,
      required this.isTwoLineTitle,
      Key? key})
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
                    leadingIcon,
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
                            isTwoLineTitle
                                ? Image.asset(
                                    handIcon,
                                  )
                                : Container()
                          ],
                        ),
                        isTwoLineTitle
                            ? Text(
                                "Hossam Saeed",
                                style:
                                    AppStyles.baloo2FontWith400WeightAnd22Size,
                              )
                            : Container(),
                      ],
                    )
                  ],
                ),
                isSearchableAppBar
                    ? Container(
                        margin: const EdgeInsetsDirectional.only(
                            top: 35, end: 60, start: 25),
                        child: SizedBox(
                          height: appBarSearchHeight.h,
                          child: CustomSearchField(
                            textController: TextEditingController(),
                            hintText: searchHint,
                            hintStyle: AppStyles
                                .baloo2FontWith400WeightAnd18SizeWithoutUnderline,
                          ),
                        ),
                      )
                    : Container()
              ],
            ),
            backgroundColor: primaryColor,
            toolbarHeight: isSearchableAppBar
                ? homeScreenAppBarWithSearchHeight.h
                : homeScreenAppBarHeight.h);
}
