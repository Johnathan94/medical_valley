import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:medical_valley/core/app_colors.dart';
import 'package:medical_valley/core/app_styles.dart';

extension Validations on String {
  bool isEmailValid() => RegExp(
          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
      .hasMatch(this);
}

extension BookingStatusView on int {
  Widget getBookingStatus(String text) {
    switch (this) {
      case 1:
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
          decoration: BoxDecoration(
              color: emmdiateBookingColor,
              borderRadius: BorderRadius.circular(8)),
          child: Text(
            text,
            style: AppStyles.baloo2FontWith400WeightAnd12Size
                .copyWith(color: const Color(0xff0887A4)),
          ),
        );
      case 2:
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
          decoration: BoxDecoration(
              color: const Color(0xffD9E0DF),
              borderRadius: BorderRadius.circular(8)),
          child: Text(
            text,
            style: AppStyles.baloo2FontWith400WeightAnd12Size
                .copyWith(color: const Color(0xff194F44)),
          ),
        );
      default:
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
          decoration: BoxDecoration(
              color: const Color(0xffFFE8EA),
              borderRadius: BorderRadius.circular(8)),
          child: Text(
            text,
            style: AppStyles.baloo2FontWith400WeightAnd12Size
                .copyWith(color: const Color(0xffFF686A)),
          ),
        );
    }
  }

  Widget toStatusView(String text) {
    switch (this) {
      case 1:
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 22),
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
              color: const Color(0xffCBE6EC),
              borderRadius: BorderRadius.circular(7)),
          child: Text(
            text,
            style: AppStyles.baloo2FontWith400WeightAnd14Size
                .copyWith(color: primaryColor),
          ),
        );
      case 2:
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 22),
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
              color: const Color(0xffD9E0DF),
              borderRadius: BorderRadius.circular(8)),
          child: Text(
            text,
            style: AppStyles.baloo2FontWith400WeightAnd12Size
                .copyWith(color: const Color(0xff194F44)),
          ),
        );
      default:
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 22),
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
              color: const Color(0xffFFE8EA),
              borderRadius: BorderRadius.circular(8)),
          child: Text(
            text,
            style: AppStyles.baloo2FontWith400WeightAnd12Size
                .copyWith(color: const Color(0xffFF686A)),
          ),
        );
    }
  }
}

String getGreeting(context) {
  final DateTime now = DateTime.now();
  final int currentHour = now.hour;

  if (currentHour >= 0 && currentHour < 12) {
    return AppLocalizations.of(context)!.good_morning;
  } else {
    return AppLocalizations.of(context)!.good_evening;
  }
}
