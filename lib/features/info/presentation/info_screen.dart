import 'package:flutter/material.dart';
import 'package:medical_valley/core/app_colors.dart';
import 'package:medical_valley/core/app_paddings.dart';
import 'package:medical_valley/core/app_styles.dart';
import 'package:medical_valley/core/strings/images.dart';
import 'package:medical_valley/core/widgets/GenericITextField.dart';
import 'package:medical_valley/core/widgets/custom_app_bar.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medical_valley/core/widgets/primary_button.dart';
class InfoScreen extends StatefulWidget {
  const InfoScreen({Key? key}) : super(key: key);

  @override
  State<InfoScreen> createState() => _InfoScreenState();
}

class _InfoScreenState extends State<InfoScreen> {
  TextEditingController fullNameController  = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
        appBar: MyCustomAppBar(
          header: AppLocalizations.of(context)!.medical_file,
          leadingIcon: GestureDetector(
              onTap: (){
                Navigator.pop(context);
              },
              child: const Icon(Icons.arrow_back_ios)),

        ),
        body: Padding(
          padding: bigPaddingHV,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(personImage),
                 SizedBox(height: 30.h,),
                GenericTextField(
                  fillColor: textFieldBg,
                  textController: fullNameController,
                  hintText: AppLocalizations.of(context)!.fullname,
                  hintStyle: AppStyles.baloo2FontWith400WeightAnd14Size.copyWith(color: hintTextColor),

                ),
                SizedBox(height: 17.h,),
                GenericTextField(
                  fillColor: textFieldBg,
                  textController: fullNameController,
                  hintText: AppLocalizations.of(context)!.date_of_birth,
                  hintStyle: AppStyles.baloo2FontWith400WeightAnd14Size.copyWith(color: hintTextColor),
                  suffixIcon: const Icon(Icons.calendar_month_outlined, color: hintTextColor,),
                ),
                SizedBox(height: 17.h,),
                GenericTextField(
                  fillColor: textFieldBg,
                  textController: fullNameController,
                  hintText: AppLocalizations.of(context)!.gender,
                  hintStyle: AppStyles.baloo2FontWith400WeightAnd14Size.copyWith(color: hintTextColor),
                  suffixIcon: const Icon(Icons.arrow_drop_down_rounded, color: hintTextColor,),
                ),
                SizedBox(height: 17.h,),
                GenericTextField(
                  fillColor: textFieldBg,
                  textController: fullNameController,
                  hintText: AppLocalizations.of(context)!.national_id,
                  hintStyle: AppStyles.baloo2FontWith400WeightAnd14Size.copyWith(color: hintTextColor),

                ),
                SizedBox(height: 17.h,),
                GenericTextField(
                  fillColor: whiteColor,
                  maxLines: 4,
                  enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: darkGrey),
                      borderRadius: BorderRadius.circular(8)
                  ),
                  textController: fullNameController,
                  hintText: AppLocalizations.of(context)!.notes,
                  hintStyle: AppStyles.baloo2FontWith400WeightAnd14Size.copyWith(color: hintTextColor),

                ),
                SizedBox(height: 30.h,),
                paymentButton()

              ],
            ),
          ),
        ));
  }
  paymentButton() {
    return Padding(
      padding: const EdgeInsetsDirectional.only(top: 10.0, start: 10, end: 10),
      child: PrimaryButton(text: AppLocalizations.of(context)!.payment, onPressed: (){
        Navigator.push(context, MaterialPageRoute(builder: (c){
          return const InfoScreen();
        }));
      },),
    );
  }
}
