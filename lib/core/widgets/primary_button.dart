import 'package:flutter/material.dart';
import 'package:medical_valley/core/app_colors.dart';
import 'package:medical_valley/core/app_sizes.dart';
import 'package:medical_valley/core/app_styles.dart';

class PrimaryButton extends StatelessWidget {
  final Function()? onPressed;
  final String text;
  final bool isWidgetButton;
  final bool isLightButton;
  final Widget? body;
  final Color backgroundColor;
  double? buttonCornerRadius;
  PrimaryButton(
      {this.onPressed,
        required this.text,
        this.isWidgetButton = false,
        this.isLightButton = false,
        this.body,
        this.buttonCornerRadius,
        this.backgroundColor = primaryColor,
        Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
        style: ButtonStyle(
            textStyle: MaterialStateProperty.all(
                AppStyles.baloo2FontWith400WeightAnd22Size),
            backgroundColor: MaterialStateProperty.all(backgroundColor),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(
                      buttonCornerRadius ?? loginButtonRadius),
                ))),
        onPressed: onPressed,
        child: Center(
          child: isWidgetButton
              ? body
              : Text(
            text,
            style: isLightButton
                ? AppStyles.baloo2FontWith400WeightAnd22Size
                .copyWith(color: blackColor)
                : AppStyles.baloo2FontWith400WeightAnd22Size,
          ),
        ));
  }
}
