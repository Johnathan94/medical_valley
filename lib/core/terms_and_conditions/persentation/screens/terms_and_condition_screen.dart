import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it/get_it.dart';
import 'package:medical_valley/core/app_colors.dart';
import 'package:medical_valley/core/app_styles.dart';
import 'package:medical_valley/core/terms_and_conditions/persentation/bloc/terms_and_conditions_bloc.dart';
import 'package:medical_valley/core/widgets/primary_button.dart';
import 'package:rxdart/rxdart.dart';

import '../../../../core/widgets/custom_app_bar.dart';
import '../bloc/TermsAndConditionsState.dart';

class TermsAndConditionsScreen extends StatefulWidget {
  const TermsAndConditionsScreen({Key? key}) : super(key: key);

  @override
  State<TermsAndConditionsScreen> createState() =>
      _TermsAndConditionsScreenState();
}

class _TermsAndConditionsScreenState extends State<TermsAndConditionsScreen> {
  final BehaviorSubject<bool> _checkBoxBehaviourSubject =
  BehaviorSubject<bool>();

  final TermsAndConditionsBloc _termsAndConditionsBloc = GetIt.instance<
      TermsAndConditionsBloc>();

  @override
  initState() {
    _checkBoxBehaviourSubject.sink.add(false);
    _termsAndConditionsBloc.getTermsAndConditions();
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
    return MyCustomAppBar(
      header: AppLocalizations.of(context)!.terms_and_condition,
      leadingIcon: InkWell(
        onTap: () => Navigator.of(context).pop(),
        child: const Icon(
          Icons.arrow_back,
          color: whiteColor,
        ),
      ),
    );
  }

  getBody(BuildContext context) {
    return BlocBuilder<TermsAndConditionsBloc, TermsAndConditionsState>(
      bloc: _termsAndConditionsBloc,
      builder: (context, state) {
        if (state is LoadingTermsAndConditionsState) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is SuccessTermsAndConditionsState) {
          return Stack(
            fit: StackFit.expand,
            children: [
              getTermsAndConditionsDescription(context,
              state.termsAndConditionsModel.termsConditions ?? ""),
              buildContinueWidget(context)
            ],
          );
        }else {
          return Center(
              child: Text(
                  AppLocalizations.of(context)!.there_is_no_data));
        }
      },
    );
  }

  Container getTermsAndConditionsDescription(BuildContext context, String termsConditions) {
    return Container(
        margin: const EdgeInsetsDirectional.only(top: 30, start: 30, end: 30),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Text(
                  termsConditions.toString(),
                  style: AppStyles.baloo2FontWith400WeightAnd20Size
                      .copyWith(color: blackColor),
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
                      backgroundColor: snapshot.hasData && snapshot.data == true ?
                      primaryColor : grey,
                      onPressed: snapshot.hasData &&
                      snapshot.data == true ?
                          (){
                        Navigator.pop(context);
                      } : null,
                    ),
                  )
                ],
              ),
            ),
          );
        });
  }
}