import 'package:flutter/material.dart';
import 'package:medical_valley/core/app_colors.dart';
import 'package:medical_valley/core/app_sizes.dart';
import 'package:medical_valley/core/app_styles.dart';

class PrimaryButton extends StatelessWidget {
  final Function()? onPressed;
  final String text;
  final bool isWidgetButton;
  final Widget? body;
  const PrimaryButton(
      {this.onPressed,
      required this.text,
      this.isWidgetButton = false,
      this.body,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
        style: ButtonStyle(
            textStyle: MaterialStateProperty.all(
                AppStyles.baloo2FontWith400WeightAnd22Size),
            backgroundColor: MaterialStateProperty.all(primaryColor),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(loginButtonRadius),
            ))),
        onPressed: onPressed,
        child: Center(
          child: isWidgetButton
              ? body
              : Text(
                  text,
                  style: AppStyles.baloo2FontWith400WeightAnd22Size,
                ),
        ));
  }
}
