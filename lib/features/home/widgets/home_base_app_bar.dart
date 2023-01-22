import 'package:flutter/material.dart';
import 'package:medical_valley/core/strings/images.dart';

import '../../../core/app_colors.dart';
import '../../../core/app_sizes.dart';
import '../../../core/app_styles.dart';
import '../../../core/widgets/custom_search_field.dart';

class CustomHomeAppBar extends AppBar {
  final bool isSearchableAppBar;
  final String goodMorningText;
  final String? searchHint;
  CustomHomeAppBar(
      {this.searchHint,
      required this.isSearchableAppBar,
      required this.goodMorningText,
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
                    Image.asset(
                      appIcon,
                      width: appBarIconWidth,
                      height: appBarIconHeight,
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
                Container(
                  margin: const EdgeInsetsDirectional.only(
                      top: 35, end: 60, start: 25),
                  child: SizedBox(
                    height: appBarSearchHeight,
                    child: CustomSearchField(
                      textController: TextEditingController(),
                      suffixIcon: emailIcon,
                      hintText: searchHint,
                      hintStyle: AppStyles
                          .baloo2FontWith400WeightAnd18SizeWithoutUnderline,
                    ),
                  ),
                )
              ],
            ),
            backgroundColor: primaryColor,
            toolbarHeight: isSearchableAppBar
                ? homeScreenAppBarWithSearchHeight
                : homeScreenAppBarHeight);
}
