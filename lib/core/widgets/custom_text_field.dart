import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:medical_valley/core/app_colors.dart';

class CustomTextField extends TextFormField{
  String? hintText ;
  TextStyle?  hintStyle ;
  String?  prefixIcon ;
  TextInputType? keyboardType ;
  TextEditingController textController ;
  Function (String) ? onFieldSubmit ;
  String? Function (String?) ? onValidator ;
  InputBorder? customEnabledBorder , customFocusedBorder;
   CustomTextField({required this.textController , this.hintStyle, this.onValidator, this.onFieldSubmit, this.hintText,this.keyboardType,this.prefixIcon ,
     this.customEnabledBorder ,
     this.customFocusedBorder ,
     Key? key}) : super(key: key ,
    keyboardType: keyboardType,
    controller: textController,
    onFieldSubmitted:onFieldSubmit ,
    validator: onValidator,
     textAlignVertical: TextAlignVertical.center,
    decoration:  InputDecoration(
      hintText:  hintText ?? "",
      fillColor: whiteRed100,
      prefixIcon:Padding(
        padding: const EdgeInsets.all(10.0),
        child: SvgPicture.asset(prefixIcon! , color: primaryColor,
        ),
      ),
      filled: true,
      hintStyle: hintStyle ?? const TextStyle(),
      enabledBorder: customEnabledBorder ?? OutlineInputBorder(
        borderSide: const BorderSide(color: primary100),
        borderRadius: BorderRadius.circular(18)
      ),
      focusedBorder:  customFocusedBorder ?? OutlineInputBorder(
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