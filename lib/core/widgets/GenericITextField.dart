import 'package:flutter/material.dart';
import 'package:medical_valley/core/app_colors.dart';

class GenericTextField extends TextFormField{
  String? hintText ;
  TextStyle?  hintStyle ;
  Widget?  prefixIcon ;
  Widget?  suffixIcon ;
  TextInputType? keyboardType ;
  Color? fillColor ;
  bool? isFilled ;
  int? maxLines ;
  InputBorder? enabledBorder ;
  TextEditingController textController ;
  Function (String) ? onFieldSubmit ;
  String? Function (String?) ? onValidator ;
  GenericTextField({required this.textController , this.hintStyle, this.onValidator, this.onFieldSubmit,
    this.hintText,
    this.isFilled,
    this.maxLines,
    this.enabledBorder,
    this.fillColor,
    this.keyboardType,
    this.suffixIcon,
    this.prefixIcon
    , Key? key}) : super(key: key ,
      keyboardType: keyboardType,
      controller: textController,
      onFieldSubmitted:onFieldSubmit ,
      validator: onValidator,
      maxLines: maxLines ?? 1,
      textAlignVertical: TextAlignVertical.center,
      decoration:  InputDecoration(
        hintText:  hintText ?? "",
        fillColor: fillColor ?? whiteRed100,
        prefixIcon: prefixIcon ,
        suffixIcon: suffixIcon ,
        filled: isFilled ?? true,

        hintStyle: hintStyle ?? const TextStyle(),
        enabledBorder: enabledBorder ?? InputBorder.none,
        focusedBorder:  OutlineInputBorder(
            borderSide: const BorderSide(color: primaryColor),
            borderRadius: BorderRadius.circular(18)
        ),
        errorBorder:  OutlineInputBorder(
            borderSide: const BorderSide(color: secondaryColor),
            borderRadius: BorderRadius.circular(18)
        ),
      )
  );

}