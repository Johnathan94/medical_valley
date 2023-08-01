import 'package:cool_alert/cool_alert.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it/get_it.dart';
import 'package:intl_phone_field/countries.dart';
import 'package:medical_valley/core/app_colors.dart';
import 'package:medical_valley/core/app_initialized.dart';
import 'package:medical_valley/core/app_paddings.dart';
import 'package:medical_valley/core/app_sizes.dart';
import 'package:medical_valley/core/app_styles.dart';
import 'package:medical_valley/core/dialogs/loading_dialog.dart';
import 'package:medical_valley/core/extensions/string_extensions.dart';
import 'package:medical_valley/core/strings/images.dart';
import 'package:medical_valley/core/terms_and_conditions/persentation/screens/terms_and_condition_screen.dart';
import 'package:medical_valley/core/widgets/app_bar.dart';
import 'package:medical_valley/core/widgets/custom_text_field.dart';
import 'package:medical_valley/core/widgets/phone_intl_widget.dart';
import 'package:medical_valley/core/widgets/primary_button.dart';
import 'package:medical_valley/features/auth/phone_verification/persentation/screens/phone_verification.dart';
import 'package:medical_valley/features/auth/register/data/model/register_request_model.dart';
import 'package:medical_valley/features/auth/register/presentation/register_bloc/register_bloc.dart';
import 'package:medical_valley/features/auth/register/presentation/register_bloc/register_state.dart';
import 'package:rxdart/rxdart.dart';

import '../../login/presentation/screens/login_screen.dart';
import '../../widgets/authentication_app_widget.dart';
import '../data/model/insurance_model.dart';
import '../widgets/primary_bg.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({Key? key}) : super(key: key);

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  TextEditingController controller = TextEditingController();
  TextEditingController fullNameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  BehaviorSubject<String> optionDisplayed = BehaviorSubject();
  BehaviorSubject<String> genderDisplayed = BehaviorSubject();
  RegisterBloc registerBloc = GetIt.instance<RegisterBloc>();
  final _formKey = GlobalKey<FormState>();
  String countryDial = "966";
  List<InsuranceModel> insuranceChoices = [
    InsuranceModel(true),
    InsuranceModel(false),
  ];

  @override
  void initState() {
    //close dialog
    super.initState();
  }

  @override
  void didChangeDependencies() {
    genderDisplayed.sink.add(AppLocalizations.of(context)!.male);
    optionDisplayed.sink.add(AppLocalizations.of(context)!.yes);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<RegisterBloc>(
      create: (c) => registerBloc,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: CustomAppBar(
          header: AppLocalizations.of(context)!.sign_up,
          leadingIcon: GestureDetector(
            onTap: () => Navigator.pop(context),
            child: const Icon(
              Icons.arrow_back_ios,
              color: whiteColor,
            ),
          ),
        ),
        body: Stack(
          children: [
            const PrimaryBg(),
            buildRegisterView(context),
          ],
        ),
      ),
    );
  }

  final BehaviorSubject<bool> _checkBoxBehaviourSubject =
      BehaviorSubject<bool>.seeded(false);
  Widget buildRegisterView(context) {
    final theme = Theme.of(context);
    final oldCheckboxTheme = theme.checkboxTheme;

    final newCheckBoxTheme = oldCheckboxTheme.copyWith(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
    );
    return Positioned(
      bottom: 0,
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height * .82,
        decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadiusDirectional.only(
                topStart: Radius.circular(registerBodyRadius))),
        child: Padding(
          padding: mediumPaddingHV,
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: BlocListener<RegisterBloc, RegisterState>(
                bloc: registerBloc,
                listener: (context, state) async {
                  if (state is RegisterStateLoading) {
                    await LoadingDialogs.showLoadingDialog(context);
                  } else if (state is RegisterStateSuccess) {
                    LoadingDialogs.hideLoadingDialog();
                    CoolAlert.show(
                      context: context,
                      autoCloseDuration: const Duration(seconds: 1),
                      showOkBtn: false,
                      type: CoolAlertType.success,
                      title: AppLocalizations.of(context)!.success,
                      text: AppLocalizations.of(context)!.success_registered,
                    );
                    Future.delayed(const Duration(seconds: 2), () {
                      navigateToOtpScreen(state.mobile ?? '');
                    });
                  } else if (state is RegisterStateError) {
                    LoadingDialogs.hideLoadingDialog();
                    CoolAlert.show(
                      context: context,
                      closeOnConfirmBtnTap: true,
                      type: CoolAlertType.error,
                      autoCloseDuration: const Duration(seconds: 1),
                      showOkBtn: false,
                      text: state.error,
                    );
                  }
                },
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 30.h,
                    ),
                    Text(
                      AppLocalizations.of(context)!.create_your_account,
                      style: AppStyles.headlineStyle,
                    ),
                    SizedBox(
                      height: 16.h,
                    ),
                    CustomTextField(
                      textController: controller,
                      prefixIcon: emailIcon,
                      hintText: AppLocalizations.of(context)!.email,
                      hintStyle: AppStyles.headlineStyle,
                      onValidator: (String? x) {
                        if (!x!.isEmailValid()) {
                          return AppLocalizations.of(context)!.email_invalid;
                        } else {
                          return null;
                        }
                      },
                      onChanged: (String? x) {
                        _formKey.currentState?.validate();
                      },
                    ),
                    SizedBox(
                      height: 16.h,
                    ),
                    CustomTextField(
                      textController: fullNameController,
                      prefixIcon: personImage,
                      hintText: AppLocalizations.of(context)!.fullname,
                      hintStyle: AppStyles.headlineStyle,
                      onValidator: (String? x) {
                        if (x!.isEmpty) {
                          return AppLocalizations.of(context)!.empty_field;
                        } else {
                          return null;
                        }
                      },
                      onChanged: (String? x) {
                        _formKey.currentState?.validate();
                      },
                    ),
                    SizedBox(
                      height: 16.h,
                    ),
                    PhoneIntlWidgetField(
                      phoneController,
                      true,
                      (Country country) {
                        countryDial = country.dialCode;
                      },
                    ),
                    SizedBox(
                      height: 16.h,
                    ),
                    StreamBuilder<String>(
                        stream: optionDisplayed.stream,
                        builder: (context, snapshot) {
                          return SizedBox(
                            width: MediaQuery.of(context).size.width,
                            child: DropdownButton2<String>(
                              isExpanded: true,
                              hint: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Text(
                                      AppLocalizations.of(context)!
                                          .insurance_question,
                                      style: AppStyles.headlineStyle,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  Text(
                                    optionDisplayed.value,
                                    style: AppStyles.headlineStyle,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ),
                              items: AppInitializer.optionsList
                                  .map((item) => DropdownMenuItem<String>(
                                        value: item,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              item,
                                              style: const TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black,
                                              ),
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                            optionDisplayed.value == item
                                                ? const Icon(
                                                    Icons.check_circle,
                                                    color: primaryColor,
                                                    size: 15,
                                                  )
                                                : const SizedBox()
                                          ],
                                        ),
                                      ))
                                  .toList(),
                              onChanged: (String? value) {
                                optionDisplayed.sink.add(value!);
                              },
                              icon: const Padding(
                                padding: EdgeInsetsDirectional.only(end: 8.0),
                                child: Icon(Icons.arrow_drop_down_outlined),
                              ),
                              buttonHeight: 60,
                              underline: const SizedBox(),
                              buttonDecoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color: whiteRed100,
                                  border: Border.all(color: primaryColor)),
                              buttonElevation: 2,
                              itemHeight: 45,
                              dropdownDecoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(14),
                                color: whiteColor,
                              ),
                              dropdownElevation: 8,
                              scrollbarThickness: 6,
                              scrollbarAlwaysShow: true,
                            ),
                          );
                        }),
                    SizedBox(
                      height: 16.h,
                    ),
                    StreamBuilder<String>(
                        stream: genderDisplayed.stream,
                        builder: (context, snapshot) {
                          return SizedBox(
                            width: MediaQuery.of(context).size.width,
                            child: DropdownButton2<String>(
                              isExpanded: true,
                              hint: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    AppLocalizations.of(context)!.gender,
                                    style: AppStyles.headlineStyle,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  Text(
                                    genderDisplayed.value,
                                    style: AppStyles.headlineStyle,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ),
                              items: [
                                AppLocalizations.of(context)!.male,
                                AppLocalizations.of(context)!.female,
                              ]
                                  .map((item) => DropdownMenuItem<String>(
                                        value: item,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              item,
                                              style: const TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black,
                                              ),
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                            optionDisplayed.value == item
                                                ? const Icon(
                                                    Icons.check_circle,
                                                    color: primaryColor,
                                                    size: 15,
                                                  )
                                                : const SizedBox()
                                          ],
                                        ),
                                      ))
                                  .toList(),
                              onChanged: (String? value) {
                                genderDisplayed.sink.add(value!);
                              },
                              icon: const Padding(
                                padding: EdgeInsetsDirectional.only(end: 8.0),
                                child: Icon(Icons.arrow_drop_down_outlined),
                              ),
                              buttonHeight: 60,
                              underline: const SizedBox(),
                              buttonDecoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color: whiteRed100,
                                  border: Border.all(color: primaryColor)),
                              buttonElevation: 2,
                              itemHeight: 45,
                              dropdownDecoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(14),
                                color: whiteColor,
                              ),
                              dropdownElevation: 8,
                              scrollbarThickness: 6,
                              scrollbarAlwaysShow: true,
                            ),
                          );
                        }),

                    SizedBox(
                      height: 10.h,
                    ),
                    StreamBuilder<bool>(
                        stream: _checkBoxBehaviourSubject.stream,
                        builder: (context, snapshot) {
                          return Row(
                            children: [
                              Theme(
                                data: theme.copyWith(
                                    checkboxTheme: newCheckBoxTheme),
                                child: Checkbox(
                                  value: _checkBoxBehaviourSubject.value,
                                  activeColor: primaryColor,
                                  materialTapTargetSize:
                                      MaterialTapTargetSize.shrinkWrap,
                                  onChanged: (newValue) {
                                    _checkBoxBehaviourSubject
                                        .add(newValue ?? false);
                                  },
                                ),
                              ),
                              Expanded(
                                  child: GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (c) =>
                                              const TermsAndConditionsScreen()));
                                },
                                child: Text(
                                  AppLocalizations.of(context)!
                                      .terms_and_condition_agreed,
                                  style: AppStyles
                                      .baloo2FontWith400WeightAnd18Size,
                                ),
                              ))
                            ],
                          );
                        }),
                    SizedBox(
                      height: 10.h,
                    ),
                    PrimaryButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          if (_checkBoxBehaviourSubject.value) {
                            registerBloc.registerUser(
                                RegisterEvent(RegisterRequestModel(
                              email: controller.text,
                              mobile: countryDial + phoneController.text,
                              fullName: fullNameController.text,
                              haveInsurance: optionDisplayed.value ==
                                  AppLocalizations.of(context)!.yes,
                              genderId: genderDisplayed.value ==
                                      AppLocalizations.of(context)!.male
                                  ? 1
                                  : 2,
                            )));
                          } else {
                            CoolAlert.show(
                                context: context,
                                closeOnConfirmBtnTap: true,
                                type: CoolAlertType.error,
                                autoCloseDuration: const Duration(seconds: 1),
                                showOkBtn: false,
                                text: AppLocalizations.of(context)!
                                    .you_must_accept_the_terms_and_conditions);
                          }
                        } else {
                          context.showSnackBar(AppLocalizations.of(context)!
                              .please_fill_all_data);
                        }
                      },
                      text: AppLocalizations.of(context)!.sign_up,
                    ),
                    //buildSignInApps(),
                    buildSignUp()
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  buildSignUp() {
    return Container(
      margin: const EdgeInsets.only(top: loginASignUpTextMarginTop),
      alignment: AlignmentDirectional.center,
      child: InkWell(
        onTap: () => navigateToLoginScreen(),
        child: Text.rich(TextSpan(
            style: AppStyles.baloo2FontWith500WeightAnd15Size,
            text: AppLocalizations.of(context)!.already_have_account,
            children: <InlineSpan>[
              TextSpan(
                text: AppLocalizations.of(context)!.sign_in,
                style:
                    AppStyles.baloo2FontWith700WeightAnd15SizeWithPrimaryColor,
              )
            ])),
      ),
    );
  }

  buildSignInApps() {
    return Container(
      margin: const EdgeInsets.only(top: 30),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Center(
            child: Text(
              AppLocalizations.of(context)!.sign_up_with_apps,
              style: AppStyles.baloo2FontWith700WeightAnd15Size,
            ),
          ),
          Container(
            width: loginAllAnotherAppsWidth.w,
            alignment: AlignmentDirectional.center,
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.max,
              children: [
                AuthenticationAppWidget(
                  appIcon: googleIcon,
                ),
                AuthenticationAppWidget(
                  appIcon: instagramIcon,
                ),
                AuthenticationAppWidget(
                  appIcon: twitterIcon,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  navigateToOtpScreen(String mobile) {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => PhoneVerificationScreen(
              mobile: mobile,
              openFromRegistered: true,
              hasInsurance:
                  optionDisplayed.value == AppLocalizations.of(context)!.yes,
            )));
  }

  navigateToLoginScreen() {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => const LoginScreen()));
  }
}
