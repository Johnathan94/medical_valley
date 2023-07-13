import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it/get_it.dart';
import 'package:medical_valley/core/app_colors.dart';
import 'package:medical_valley/core/app_styles.dart';
import 'package:medical_valley/core/dialogs/loading_dialog.dart';
import 'package:medical_valley/core/widgets/snackbars.dart';
import 'package:medical_valley/features/auth/phone_verification/persentation/bloc/otp_bloc.dart';
import 'package:medical_valley/features/info/presentation/medical_file_screen.dart';

import '../../../../../core/app_sizes.dart';
import '../../../../../core/widgets/app_bar_with_null_background.dart';
import '../../../../welcome_page/presentation/screens/welcome_page_screen.dart';

class PhoneVerificationScreen extends StatefulWidget {
  final String mobile;
  final bool openFromRegistered;
  final bool? hasInsurance;
  const PhoneVerificationScreen(
      {required this.mobile,
      required this.openFromRegistered,
      this.hasInsurance,
      Key? key})
      : super(key: key);

  @override
  State<PhoneVerificationScreen> createState() =>
      _PhoneVerificationScreenState();
}

class _PhoneVerificationScreenState extends State<PhoneVerificationScreen> {
  OtpBloc otpBloc = GetIt.instance<OtpBloc>();
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBarWithoutBackground(
            header: AppLocalizations.of(context)!.phone_verification,
            leadingIcon: InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: const Icon(
                Icons.arrow_back_ios,
                color: blackColor,
              ),
            )),
        body: Center(
          child: SizedBox(
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  buildPhoneVerificationDesc(),
                  SizedBox(
                    height: 150.h,
                  ),
                  BlocListener(
                      bloc: otpBloc,
                      child: const SizedBox(),
                      listener: (c, state) async {
                        if (state is LoadingOtpState) {
                          await LoadingDialogs.showLoadingDialog(context);
                        } else if (state is SuccessOtpState) {
                          LoadingDialogs.hideLoadingDialog();
                          CoolAlert.show(
                            barrierDismissible: false,
                            context: context,
                            autoCloseDuration:
                                const Duration(milliseconds: 300),
                            showOkBtn: false,
                            type: CoolAlertType.success,
                            text: AppLocalizations.of(context)!.otp_success,
                          );
                          if (widget.openFromRegistered &&
                              widget.hasInsurance != null &&
                              widget.hasInsurance!) {
                            Future.delayed(const Duration(milliseconds: 350),
                                () {
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (c) => const MedicalFileScreen(
                                          openFirstTime: true)));
                            });
                          } else {
                            Future.delayed(const Duration(milliseconds: 350),
                                () {
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (c) =>
                                          const WelcomePageScreen()));
                            });
                          }
                        } else {
                          LoadingDialogs.hideLoadingDialog();
                          CoolAlert.show(
                            context: context,
                            closeOnConfirmBtnTap: true,
                            type: CoolAlertType.error,
                            autoCloseDuration: const Duration(seconds: 1),
                            showOkBtn: false,
                            text: AppLocalizations.of(context)!.invalid_otp,
                          );
                        }
                      }),
                  buildOtpField(context),
                  SizedBox(
                    height: 100.h,
                  ),
                  buildConfirmButton(context)
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  buildPhoneVerificationDesc() {
    return Text(
      AppLocalizations.of(context)!.enter_you_otp,
      style: AppStyles.baloo2FontWith400WeightAnd25Size,
    );
  }

  String code = "";
  buildOtpField(context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: OtpTextField(
        fieldWidth: otpFieldWidth.w,
        numberOfFields: otpFieldNumber,
        borderWidth: otpFieldBorderWidth.w,
        enabledBorderColor: greyWith80Percentage,
        focusedBorderColor: primaryColor,
        handleControllers: (List<TextEditingController?> controller) {
          controller[1]?.addListener(() {
            FocusScope.of(context).unfocus();
          });
          controller[2]?.addListener(() {
            FocusScope.of(context).unfocus();
          });
          controller[3]?.addListener(() {
            FocusScope.of(context).unfocus();
          });
          controller[4]?.addListener(() {
            FocusScope.of(context).unfocus();
          });
          controller[5]?.addListener(() {
            FocusScope.of(context).unfocus();
          });
        },
        onSubmit: (String text) {
          code = text;
        },
        borderRadius:
            const BorderRadius.all(Radius.circular(otpFieldBorderRadius)),
        showFieldAsBox: true,
      ),
    );
  }

  buildConfirmButton(BuildContext context) {
    return Container(
      margin: const EdgeInsetsDirectional.only(
          start: loginButtonMarginHorizontal, end: loginButtonMarginHorizontal),
      child: TextButton(
          style: ButtonStyle(
              textStyle: MaterialStateProperty.all(
                  AppStyles.baloo2FontWith400WeightAnd22Size),
              backgroundColor: MaterialStateProperty.all(primaryColor),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(loginButtonRadius),
              ))),
          onPressed: () {
            code.length == 6
                ? otpBloc.verifyOtp(code, widget.mobile)
                : context.showSnackBar(AppLocalizations.of(context)!.otp_error);
          },
          child: Center(
            child: Text(
              AppLocalizations.of(context)!.continue_text,
              style: AppStyles.baloo2FontWith400WeightAnd22Size,
            ),
          )),
    );
  }
}
