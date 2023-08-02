import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:medical_valley/core/app_styles.dart';
import 'package:medical_valley/core/strings/images.dart';
import 'package:medical_valley/core/widgets/custom_app_bar.dart';

class NoLocationServiceScreen extends StatelessWidget {
  const NoLocationServiceScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyCustomAppBar(
        header: AppLocalizations.of(context)!.medical_file,
        leadingIcon: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: const Icon(Icons.arrow_back_ios)),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: SvgPicture.asset(noLocationService),
          ),
          const SizedBox(
            height: 10,
          ),
          SvgPicture.asset(onNo),
          const SizedBox(
            height: 40,
          ),
          Text(
            AppLocalizations.of(context)!.open_location_service,
            style: AppStyles.baloo2FontWith400WeightAnd20Size
                .copyWith(color: Colors.black),
            textAlign: TextAlign.center,
          )
        ],
      ),
    );
  }
}
