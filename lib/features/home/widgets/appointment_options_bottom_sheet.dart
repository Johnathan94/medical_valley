import 'package:flutter/material.dart';
import 'package:medical_valley/core/app_colors.dart';
import 'package:medical_valley/core/app_paddings.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:medical_valley/core/app_styles.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medical_valley/features/home/widgets/option_button.dart';
import 'package:medical_valley/features/offers/presentation/offers_screen.dart';
class AppointmentsBottomSheet extends StatelessWidget {
  const AppointmentsBottomSheet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 290.h,
      padding: bigPaddingHV,
      decoration: BoxDecoration(
        color: whiteColor,
        boxShadow:const [
          BoxShadow(
            offset: Offset(2, 1),
            blurRadius: 5,
            spreadRadius: 1,
            color: shadowGrey
          )
        ],
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                  onTap: (){
                    Navigator.pop(context);
                  },
                  child : const Icon(Icons.close , color: blackColor,)),
              Text(AppLocalizations.of(context)!.are_you_sure_about_the_service , style: AppStyles.baloo2FontWith400WeightAnd20Size.copyWith(color: blackColor),),
              const SizedBox()
            ],

          ),
          SizedBox(height: 23.h,),
          Row(
            children: [
              Expanded(child: OptionButton(title: AppLocalizations.of(context)!.immediate, activatedColor: darkGreen,unActivatedColor: buttonGrey, isActivated: false,)),
              const SizedBox(width: 8,),
              Expanded(child: OptionButton(title: AppLocalizations.of(context)!.earliest, activatedColor: primaryColor,unActivatedColor: buttonGrey, isActivated: true,))
            ],
          ),
          SizedBox(height: 14.h,),
          Row(
            children: [
              Expanded(child: OptionButton(title: AppLocalizations.of(context)!.schedule_on, activatedColor: secondaryColor,unActivatedColor: buttonGrey, isActivated: true,)),
            ],
          ),
          SizedBox(height: 14.h,),
          Row(
            children: [
              Expanded(child: GestureDetector (
                  onTap: (){
                    Navigator.pop(context);
                    Navigator.push(context, MaterialPageRoute(builder: (c)=>OffersScreen()));
                  },
                  child: OptionButton(textStyle : AppStyles.baloo2FontWith700WeightAnd22Size.copyWith(color: whiteColor) , title: AppLocalizations.of(context)!.confirm, activatedColor: primaryColor,unActivatedColor: buttonGrey, isActivated: true,))),
            ],
          )

        ],
      ),
    );
  }
}
