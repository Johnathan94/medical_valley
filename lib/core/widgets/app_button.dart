import 'package:flutter/material.dart';

import '../app_colors.dart';
import '../app_sizes.dart';
import '../app_styles.dart';

class ApplicationButton extends Widget {
  final String buttonText;
  final Function onPressedAction;

  ApplicationButton({required this.buttonText, required this.onPressedAction}) {
    TextButton(
        style: ButtonStyle(
            textStyle: MaterialStateProperty.all(
                AppStyles.baloo2FontWith400WeightAnd22Size),
            backgroundColor: MaterialStateProperty.all(primaryColor),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(loginButtonRadius),
            ))),
        onPressed: () {
          onPressedAction();
        },
        child: Center(
          child: Text(
            buttonText,
            style: AppStyles.baloo2FontWith400WeightAnd22Size,
          ),
        ));
  }

  @override
  Element createElement() {
    throw UnimplementedError();
  }
}
