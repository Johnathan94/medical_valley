import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medical_valley/core/app_colors.dart';
import 'package:medical_valley/core/app_styles.dart';
import 'package:medical_valley/core/widgets/primary_button.dart';
import 'package:rxdart/rxdart.dart';

import '../../../../core/app_sizes.dart';

class TermsAndConditionsScreen extends StatefulWidget {
  const TermsAndConditionsScreen({Key? key}) : super(key: key);

  @override
  State<TermsAndConditionsScreen> createState() =>
      _TermsAndConditionsScreenState();
}

class _TermsAndConditionsScreenState extends State<TermsAndConditionsScreen> {
  final BehaviorSubject<bool> _checkBoxBehaviourSubject =
      BehaviorSubject<bool>();

  @override
  initState() {
    _checkBoxBehaviourSubject.sink.add(false);
    super.initState();
  }

  @override
  dispose() {
    _checkBoxBehaviourSubject.stream.drain();
    _checkBoxBehaviourSubject.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getAppBar(context),
      body: getBody(context),
    );
  }

  getAppBar(BuildContext context) {
    return AppBar(
      title: Text(AppLocalizations.of(context)!.terms_and_condition,
          style: AppStyles.baloo2FontWith600WeightAnd25SizeBlackText),
      leading: InkWell(
        onTap: () => Navigator.of(context).pop(),
        child: const Icon(
          Icons.arrow_back,
          color: blackColor,
        ),
      ),
      elevation: 0,
      backgroundColor: whiteColor,
      toolbarHeight: customAppBarHeight.h - 30,
    );
  }

  getBody(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        getTermsAndConditionsDescription(context),
        buildContinueWidget(context)
      ],
    );
  }

  Container getTermsAndConditionsDescription(BuildContext context) {
    return Container(
        margin: const EdgeInsetsDirectional.only(top: 30, start: 30, end: 30),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Text(
                  AppLocalizations.of(context)!.terms_and_condition_desc,
                  style: AppStyles.baloo2FontWith400WeightAnd20SizeBlackColor,
                ),
              ),
            ),
            SizedBox(
              height: 186.h,
            )
          ],
        ));
  }

  buildContinueWidget(BuildContext context) {
    final theme = Theme.of(context);
    final oldCheckboxTheme = theme.checkboxTheme;

    final newCheckBoxTheme = oldCheckboxTheme.copyWith(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
    );
    return StreamBuilder<bool>(
        stream: _checkBoxBehaviourSubject,
        builder: (context, snapshot) {
          return Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              color: whiteColor,
              height: 186.h,
              padding: const EdgeInsetsDirectional.only(top: 17, start: 26),
              child: Column(
                children: [
                  Row(
                    children: [
                      Theme(
                        data: theme.copyWith(checkboxTheme: newCheckBoxTheme),
                        child: Checkbox(
                          value: _checkBoxBehaviourSubject.value,
                          activeColor: primaryColor,
                          materialTapTargetSize:
                              MaterialTapTargetSize.shrinkWrap,
                          onChanged: (newValue) {
                            _checkBoxBehaviourSubject.sink
                                .add(newValue ?? false);
                          },
                        ),
                      ),
                      Expanded(
                          child: Text(
                        AppLocalizations.of(context)!
                            .terms_and_condition_agreed,
                        style: AppStyles.baloo2FontWith400WeightAnd18Size,
                      ))
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsetsDirectional.only(
                        top: 44, start: 5.0, end: 40),
                    child: PrimaryButton(
                      text: AppLocalizations.of(context)!.continue_text,
                    ),
                  )
                ],
              ),
            ),
          );
        });
  }
}
