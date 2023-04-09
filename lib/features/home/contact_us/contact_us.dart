import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
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
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _facebookController = TextEditingController();
  final TextEditingController _twitterController = TextEditingController();

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
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        const SizedBox(
          height: 50,
        ),
        buildContactUsSmallField(
            AppLocalizations.of(context)!.email, emailIcon, _emailController),
        buildContactUsSmallField(AppLocalizations.of(context)!.facebook_page,
            facebookIcon, _facebookController),
        buildContactUsSmallField(AppLocalizations.of(context)!.twitter_page,
            twitterIcon, _twitterController),
        buildLargeContactUsField(),
        buildInputButton(),
      ],
    );
  }

  buildContactUsSmallField(String hint,String emailIcon, controller) {
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
      padding: const EdgeInsetsDirectional.only(top: 56, start: 32, end: 32),
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
