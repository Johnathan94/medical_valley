import 'package:flutter/material.dart';
import 'package:medical_valley/core/app_colors.dart';

class CustomSearchField extends TextFormField {
  String? hintText;
  TextStyle? hintStyle;
  String? suffixIcon;
  TextInputType? keyboardType;
  TextEditingController textController;
  Function(String)? onFieldSubmit;
  String? Function(String?)? onValidator;
  CustomSearchField(
      {required this.textController,
      this.hintStyle,
      this.onValidator,
      this.onFieldSubmit,
      this.hintText,
      this.keyboardType,
      this.suffixIcon,
      Key? key})
      : super(
            key: key,
            keyboardType: keyboardType,
            controller: textController,
            onFieldSubmitted: onFieldSubmit,
            validator: onValidator,
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
