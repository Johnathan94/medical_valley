import 'package:flutter/material.dart';
import 'package:medical_valley/core/app_colors.dart';
import 'package:medical_valley/core/app_paddings.dart';
import 'package:medical_valley/core/app_styles.dart';

class OptionButton extends StatelessWidget {
  final Color activatedColor , unActivatedColor ;
  final bool isActivated ;
  final String title ;
  final TextStyle? textStyle ;
  
  const OptionButton({required this.title ,required this.isActivated ,required this.activatedColor , required this.unActivatedColor ,this.textStyle,Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: smallPaddingHV,
      decoration: BoxDecoration(
        color: isActivated ? activatedColor : unActivatedColor,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(title , style:textStyle ?? AppStyles.baloo2FontWith400WeightAnd18Size.copyWith(color: isActivated ? whiteColor : blackColor, decoration: TextDecoration.none),),
    );
  }
}
