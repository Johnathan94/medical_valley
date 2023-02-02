import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:medical_valley/core/app_colors.dart';

import '../../../../core/widgets/custom_app_bar.dart';

class CalendarScreen extends StatefulWidget {
  const CalendarScreen({Key? key}) : super(key: key);

  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getAppBar(),
      body: getBody(),
    );
  }

  getAppBar() {
    return MyCustomAppBar(
      header: AppLocalizations.of(context)!.schedule_an_appointment,
      isActionButtonShown: false,
      leadingIcon: InkWell(
        onTap: () => Navigator.pop(context),
        child: const Icon(
          Icons.close,
          color: whiteColor,
        ),
      ),
    );
  }

  getBody() {
    return  Container();
  }
}
