import 'package:flutter/material.dart';
import 'package:medical_valley/core/app_colors.dart';
import 'package:medical_valley/core/app_styles.dart';
enum ButtonType {
  book , negotiate
}
class OffersOptionsButton extends StatelessWidget {
  late ButtonType buttonType ;
   final String title ;
   final bool isEnabled ;


  OffersOptionsButton({required this.buttonType,required this.title,required this.isEnabled});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: buttonType == ButtonType.book ? primaryColor : isEnabled ? secondaryColor  : secondaryColorLight,
      borderRadius:
      buttonType == ButtonType.negotiate ?
      const BorderRadiusDirectional.only(topEnd: Radius.circular(8), bottomStart: Radius.circular(8)):
      const BorderRadiusDirectional.only(bottomEnd: Radius.circular(8), topStart: Radius.circular(8)),
      ),
      alignment: Alignment.center,
      child: Text(
        title ,
        style: AppStyles.baloo2FontWith400WeightAnd18Size.copyWith(color: whiteColor , decoration: TextDecoration.none),
      ),
    );
  }
}
