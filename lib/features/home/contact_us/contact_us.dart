import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl_phone_field/countries.dart';
import 'package:medical_valley/core/extensions/string_extensions.dart';
import 'package:medical_valley/core/widgets/phone_intl_widget.dart';
import 'package:medical_valley/core/widgets/primary_button.dart';

import '../../../../core/app_colors.dart';
import '../../../../core/app_styles.dart';
import '../../../../core/strings/images.dart';
import '../../../../core/widgets/custom_app_bar.dart';
import '../../../../core/widgets/custom_text_field.dart';

class ContactUsScreen extends StatefulWidget {
  const ContactUsScreen({Key? key}) : super(key: key);

  @override
  State<ContactUsScreen> createState() => _ContactUsScreenState();
}

class _ContactUsScreenState extends State<ContactUsScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController fullNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(
              height: 50,
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
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
                      Text(AppLocalizations.of(context)!.email),
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
            SizedBox(
              height: 16.h,
            ),
            TextFormField(
              validator: (String? x) {
                if (x!.isEmpty) {
                  return AppLocalizations.of(context)!.empty_field;
                }
              },
              controller: emailController,
              decoration: InputDecoration(
                fillColor: buttonGrey,
                filled: true,
                enabledBorder: InputBorder.none,
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
                }
              },
              controller: fullNameController,
              decoration: InputDecoration(
                fillColor: buttonGrey,
                filled: true,
                enabledBorder: InputBorder.none,
                hintText: AppLocalizations.of(context)!.fullname,
                hintStyle: AppStyles.headlineStyle,
              ),
            ),
            SizedBox(
              height: 16.h,
            ),
            PhoneIntlWidgetField(phoneController, (Country country) {}),
            buildLargeContactUsField(),
            buildInputButton(),
          ],
        ),
      ),
    );
  }

  buildContactUsSmallField(String hint, String emailIcon, controller) {
    return Padding(
      padding: const EdgeInsetsDirectional.only(start: 27, end: 27, bottom: 15),
      child: CustomTextField(
        textController: controller,
        prefixIcon: emailIcon,
        hintText: hint,
        hintStyle: AppStyles.baloo2FontWith700WeightAnd15Size,
        customEnabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: primaryColor),
            borderRadius: BorderRadius.circular(12)),
        customFocusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: primaryColor),
            borderRadius: BorderRadius.circular(12)),
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
          const TextField(
            keyboardType: TextInputType.multiline,
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
      child: PrimaryButton(text: AppLocalizations.of(context)!.input),
    );
  }
}
