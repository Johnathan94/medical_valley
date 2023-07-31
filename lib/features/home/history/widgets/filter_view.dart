import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:medical_valley/core/app_colors.dart';
import 'package:medical_valley/core/app_paddings.dart';
import 'package:medical_valley/core/app_styles.dart';
import 'package:medical_valley/core/strings/images.dart';

class FilterView extends StatelessWidget {
  final int totalRequestsNumber;
  final Function() onSortTapped;
  const FilterView(
      {required this.totalRequestsNumber, required this.onSortTapped, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: smallPaddingHV,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              SvgPicture.asset("${iconsPath}filter.svg"),
              const SizedBox(
                width: 8,
              ),
              Text(
                "$totalRequestsNumber ${AppLocalizations.of(context)!.requests}",
                style: AppStyles.baloo2FontWith400WeightAnd18Size.copyWith(
                    color: headerGrey, decoration: TextDecoration.none),
              )
            ],
          ),
          Row(
            children: [
              Text(
                AppLocalizations.of(context)!.sort,
                style: AppStyles.baloo2FontWith400WeightAnd12Size.copyWith(),
              ),
              InkWell(
                  onTap: onSortTapped,
                  child: SvgPicture.asset("${iconsPath}sort.svg")),
            ],
          ),
        ],
      ),
    );
  }
}
