import 'package:flutter/material.dart';
import 'package:intl_phone_field/phone_number.dart';
import 'package:medical_valley/core/app_colors.dart';
import 'package:medical_valley/core/app_sizes.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import '../app_sizes.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
class PhoneIntlWidgetField extends StatelessWidget {
  final TextEditingController phoneController ;
  const PhoneIntlWidgetField(this.phoneController ,{Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IntlPhoneField(
      initialValue: "",
      disableLengthCheck: true,
      controller: phoneController,
      cursorColor: primaryColor,
      dropdownIconPosition: IconPosition.trailing,
      validator: (PhoneNumber? number){
        if(number!.completeNumber.length != 13){
          return AppLocalizations.of(context)!.invalid_phone;
        }
      },
      autovalidateMode: AutovalidateMode.onUserInteraction,
      dropdownIcon: const Icon(Icons.arrow_drop_down , color: greyWith80Percentage,),
      flagsButtonPadding: const EdgeInsetsDirectional.only(
          start: loginMobileNumberFieldPadding),
      decoration: const InputDecoration(
        filled: true,
        fillColor: whiteRed100,
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: primaryColor),
            borderRadius: BorderRadius.all(
                Radius.circular(loginMobileNumberFieldRadius))),
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: primaryColor),
            borderRadius: BorderRadius.all(
                Radius.circular(loginMobileNumberFieldRadius))),
      ),
      initialCountryCode: 'SA',
      onChanged: (phone) {
        print(phone.completeNumber);
      },
    );
  }
}
