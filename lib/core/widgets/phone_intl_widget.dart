import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl_phone_field/countries.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:intl_phone_field/phone_number.dart';
import 'package:medical_valley/core/app_colors.dart';
import 'package:medical_valley/core/app_sizes.dart';

class PhoneIntlWidgetField extends StatelessWidget {
  final TextEditingController phoneController;
  final Function(Country country) onCountryChanged;
  final Color? fillColor;
  final Color? borderColor;
  const PhoneIntlWidgetField(this.phoneController, this.onCountryChanged,
      {this.fillColor, this.borderColor, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IntlPhoneField(
        initialValue: "",
        disableLengthCheck: true,
        controller: phoneController,
        cursorColor: primaryColor,
        dropdownIconPosition: IconPosition.trailing,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        validator: (PhoneNumber? phoneNumber) {
          if (phoneNumber!.number.length == 10 ||
              phoneNumber.number.length == 9) {
            return null;
          } else {
            return AppLocalizations.of(context)!.invalid_phone_number;
          }
        },
        dropdownIcon: const Icon(
          Icons.arrow_drop_down,
          color: greyWith80Percentage,
        ),
        flagsButtonPadding: const EdgeInsetsDirectional.only(
            start: loginMobileNumberFieldPadding),
        decoration: InputDecoration(
          filled: true,
          fillColor: fillColor ?? whiteRed100,
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: borderColor ?? primaryColor),
              borderRadius: const BorderRadius.all(
                  Radius.circular(loginMobileNumberFieldRadius))),
          focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: primaryColor),
              borderRadius: BorderRadius.all(
                  Radius.circular(loginMobileNumberFieldRadius))),
        ),
        initialCountryCode: 'SA',
        onChanged: (phone) {
          phone.completeNumber;
        },
        onCountryChanged: (c) {
          onCountryChanged(c);
        });
  }
}
