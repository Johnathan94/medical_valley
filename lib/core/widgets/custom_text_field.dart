import 'package:flutter/material.dart';
import 'package:medical_valley/core/app_colors.dart';

class CustomTextField extends TextFormField{
  String? hintText ;
  TextStyle?  hintStyle ;
  String?  prefixIcon ;
  TextInputType? keyboardType ;
  TextEditingController textController ;
  Function (String) ? onFieldSubmit ;
  String? Function (String?) ? onValidator ;
   CustomTextField({required this.textController , this.hintStyle, this.onValidator, this.onFieldSubmit, this.hintText,this.keyboardType,this.prefixIcon , Key? key}) : super(key: key ,
    keyboardType: keyboardType,
    controller: textController,
    onFieldSubmitted:onFieldSubmit ,
    validator: onValidator,
     textAlignVertical: TextAlignVertical.center,
    decoration:  InputDecoration(
      hintText:  hintText ?? "",
      fillColor: whiteRed100,
      prefixIcon: const Icon(Icons.mail_outline , color: primaryColor,),
      filled: true,
      hintStyle: hintStyle ?? const TextStyle(),
      enabledBorder:  OutlineInputBorder(
        borderSide: const BorderSide(color: primary100),
        borderRadius: BorderRadius.circular(18)
      ),
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