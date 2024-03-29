import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get_it/get_it.dart';
import 'package:intl_phone_field/countries.dart';
import 'package:medical_valley/core/dialogs/loading_dialog.dart';
import 'package:medical_valley/core/extensions/string_extensions.dart';
import 'package:medical_valley/core/shared_pref/shared_pref.dart';
import 'package:medical_valley/core/widgets/phone_intl_widget.dart';
import 'package:medical_valley/core/widgets/primary_button.dart';
import 'package:medical_valley/features/auth/phone_verification/data/model/otp_response_model.dart';
import 'package:medical_valley/features/home/contact_us/data/model/contact_us_response_model.dart';
import 'package:medical_valley/features/home/contact_us/presentation/contact_us_bloc.dart';

import '../../../../core/app_colors.dart';
import '../../../../core/app_styles.dart';
import '../../../../core/strings/images.dart';
import '../../../../core/widgets/custom_app_bar.dart';

class ContactUsScreen extends StatefulWidget {
  const ContactUsScreen({Key? key}) : super(key: key);

  @override
  State<ContactUsScreen> createState() => _ContactUsScreenState();
}

class _ContactUsScreenState extends State<ContactUsScreen> {
  final TextEditingController problemController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController fullNameController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final ContactUsBloc contactUsBloc = GetIt.instance<ContactUsBloc>();
  late String phoneNumber;
  @override
  void initState() {
    UserDate currentUser = UserDate.fromJson(LocalStorageManager.getUser()!);
    fullNameController.text = currentUser.fullName ?? "";
    emailController.text = currentUser.email ?? "";
    phoneNumber = currentUser.mobile ?? "";
    phoneController.text = seperatePhoneAndDialCode("+$phoneNumber")[1];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: getAppBar(),
      body: getContactUsBody(),
    );
  }

  getAppBar() {
    return MyCustomAppBar(
      header: AppLocalizations.of(context)!.contact_us,
      leadingIcon: InkWell(
        onTap: () => Navigator.of(context).pop(),
        child: const Icon(
          Icons.arrow_back_ios,
          color: whiteColor,
        ),
      ),
    );
  }

  getContactUsBody() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(
                  height: 50,
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  decoration: BoxDecoration(
                      color: whiteRed100,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: primaryColor)),
                  child: Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SvgPicture.asset(
                            emailIcon,
                            width: 15,
                            height: 15,
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          SvgPicture.asset(
                            faceBookIcon,
                            width: 15,
                            height: 15,
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          SvgPicture.asset(
                            notificationIcon,
                            width: 15,
                            height: 15,
                          ),
                        ],
                      ),
                      const SizedBox(
                        width: 12,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(AppLocalizations.of(context)!.instagram),
                          const SizedBox(
                            height: 8,
                          ),
                          Text(AppLocalizations.of(context)!.medical_valley),
                          const SizedBox(
                            height: 8,
                          ),
                          Text(AppLocalizations.of(context)!.medical_valley)
                        ],
                      )
                    ],
                  ),
                ),
                BlocListener<ContactUsBloc, ContactUsState>(
                  bloc: contactUsBloc,
                  child: const SizedBox(),
                  listener: (BuildContext context, state) async {
                    if (state is ContactUsStateLoading) {
                      await LoadingDialogs.showLoadingDialog(context);
                    } else if (state is ContactUsStateSuccess) {
                      LoadingDialogs.hideLoadingDialog();
                      CoolAlert.show(
                        barrierDismissible: false,
                        context: context,
                        autoCloseDuration: const Duration(seconds: 1),
                        showOkBtn: false,
                        type: CoolAlertType.success,
                        title: AppLocalizations.of(context)!.success,
                        text: AppLocalizations.of(context)!.message_contact_us,
                      );
                      Future.delayed(const Duration(seconds: 1),
                          () => Navigator.pop(context));
                    } else {
                      LoadingDialogs.hideLoadingDialog();
                      CoolAlert.show(
                        context: context,
                        closeOnConfirmBtnTap: true,
                        autoCloseDuration: const Duration(seconds: 1),
                        showOkBtn: false,
                        type: CoolAlertType.error,
                        title: AppLocalizations.of(context)!.error,
                        text:
                            AppLocalizations.of(context)!.something_went_wrong,
                      );
                    }
                  },
                ),
                SizedBox(
                  height: 16.h,
                ),
                TextFormField(
                  validator: (String? x) {
                    if (!x!.isEmailValid()) {
                      return AppLocalizations.of(context)!.email_invalid;
                    }
                  },
                  controller: emailController,
                  textAlignVertical: TextAlignVertical.center,
                  enabled: false,
                  decoration: InputDecoration(
                    fillColor: textFieldBg,
                    filled: true,
                    enabledBorder: InputBorder.none,
                    isDense: true,
                    focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: primaryColor)),
                    hintText: AppLocalizations.of(context)!.email,
                    hintStyle: AppStyles.headlineStyle,
                  ),
                ),
                SizedBox(
                  height: 16.h,
                ),
                TextFormField(
                  validator: (String? x) {
                    if (x!.isEmpty) {
                      return AppLocalizations.of(context)!.empty_field;
                    } else {
                      return null;
                    }
                  },
                  controller: fullNameController,
                  enabled: false,
                  decoration: InputDecoration(
                    fillColor: textFieldBg,
                    filled: true,
                    enabledBorder: InputBorder.none,
                    isDense: true,
                    focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: primaryColor)),
                    hintText: AppLocalizations.of(context)!.fullname,
                    hintStyle: AppStyles.headlineStyle,
                  ),
                ),
                SizedBox(
                  height: 16.h,
                ),
                Directionality(
                  textDirection:
                      LocalStorageManager.getCurrentLanguage() == "ar"
                          ? TextDirection.ltr
                          : TextDirection.ltr,
                  child: PhoneIntlWidgetField(
                    phoneController,
                    false,
                    countryCode: seperatePhoneAndDialCode("+$phoneNumber")[0],
                    (Country country) {},
                    fillColor: textFieldBg,
                    borderColor: Colors.transparent,
                  ),
                ),
                buildLargeContactUsField(),
                buildInputButton(),
                SizedBox(
                  height: 400.h,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  buildLargeContactUsField() {
    return Padding(
      padding: const EdgeInsetsDirectional.only(top: 20, start: 32, end: 32),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            AppLocalizations.of(context)!.input_your_problem,
            style: AppStyles.hintStyle.copyWith(color: headerGrey),
          ),
          const SizedBox(
            height: 10,
          ),
          TextFormField(
            keyboardType: TextInputType.multiline,
            controller: problemController,
            validator: (String? s) {
              return s!.isEmpty
                  ? AppLocalizations.of(context)!.you_have_to_write_your_problem
                  : null;
            },
            onChanged: (String x) {
              _formKey.currentState!.validate();
            },
            decoration: const InputDecoration(
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: greenCheckBox)),
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: primaryColor)),
            ),
            minLines: 8, //Normal textInputField will be displayed
            maxLines: 15, // when user presses enter it will adapt to it
          ),
        ],
      ),
    );
  }

  buildInputButton() {
    return Padding(
      padding: const EdgeInsetsDirectional.only(start: 22, end: 22, top: 35),
      child: PrimaryButton(
          text: AppLocalizations.of(context)!.send,
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              contactUsBloc.contactUs(ContactUsEvent(ContactUsModel(
                  email: emailController.text,
                  phone: phoneNumber,
                  fullName: fullNameController.text,
                  problem: problemController.text)));
            }
          }),
    );
  }
}
