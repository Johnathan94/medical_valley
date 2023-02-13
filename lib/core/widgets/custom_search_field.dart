import 'package:flutter/material.dart';
import 'package:medical_valley/core/app_colors.dart';
import 'package:medical_valley/core/app_styles.dart';

class CustomSearchField extends TextField {
  String? hintText;
  TextStyle? hintStyle;
  String? suffixIcon;
  TextInputType? myKeyboardType;
  TextEditingController textController;
  Function(String)? onFieldSubmit;
  String? Function(String?)? onValidator;
  CustomSearchField(
      {required this.textController,
      this.hintStyle,
      this.onValidator,
      this.onFieldSubmit,
      this.hintText,
      this.myKeyboardType,
      this.suffixIcon,
      Key? key})
      : super(
            key: key,
            keyboardType: myKeyboardType,
            controller: textController,
            onSubmitted: (String? text){
              onFieldSubmit!(text!);
            },
      style: AppStyles.baloo2FontWith400WeightAnd18Size.copyWith(color: Colors.white,decoration: TextDecoration.none),
            textAlignVertical: TextAlignVertical.bottom,
            decoration: InputDecoration(
              hintText: hintText ?? "",
              fillColor: primaryLiteColor,
              suffixIcon: const Icon(
                Icons.search,
                color: whiteColor,
                size: 35,
              ),
              filled: true,
              hintStyle: hintStyle ?? const TextStyle(),
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(9)),
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(9)),
              errorBorder: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(9)),
            ));
}
