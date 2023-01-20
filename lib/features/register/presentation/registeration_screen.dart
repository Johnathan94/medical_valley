import 'package:flutter/material.dart';
import 'package:medical_valley/core/app_colors.dart';
import 'package:medical_valley/core/app_paddings.dart';
import 'package:medical_valley/core/app_sizes.dart';
import 'package:medical_valley/core/app_styles.dart';
import 'package:medical_valley/core/strings/images.dart';
import 'package:medical_valley/core/widgets/app_bar.dart';
import 'package:medical_valley/core/widgets/custom_text_field.dart';
import 'package:medical_valley/core/widgets/phone_intl_widget.dart';
import 'package:medical_valley/core/widgets/primary_button.dart';
import 'package:medical_valley/features/auth/presentation/screens/login_screen.dart';
import 'package:medical_valley/features/register/data/insurance_model.dart';
import 'package:medical_valley/features/register/widgets/primary_bg.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rxdart/rxdart.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({Key? key}) : super(key: key);

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  TextEditingController controller = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  BehaviorSubject<bool> optionDisplayed = BehaviorSubject();
  BehaviorSubject<int> insuranceOption = BehaviorSubject();
  List<InsuranceModel> insuranceChoices = [
    InsuranceModel(true),
    InsuranceModel(false),
  ];

  @override
  void initState() {
    optionDisplayed.sink.add(false);
    insuranceOption.sink.add(0);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        header: AppLocalizations.of(context)!.sign_up,
        leadingIcon: const Icon(
          Icons.arrow_back_ios,
          color: whiteColor,
        ),
      ),
      body: Stack(
        children: [const PrimaryBg(), buildRegisterView()],
      ),
    );
  }

  Widget buildRegisterView() {
    return Positioned(
      bottom: 0,
      child: GestureDetector(
        onTap: ()=> optionDisplayed.sink.add(false),
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
                  ),
                  SizedBox(
                    height: 16.h,
                  ),
                  const PhoneIntlWidgetField(),
                  SizedBox(
                    height: 16.h,
                  ),
                  GestureDetector(
                    onTap: (){
                    optionDisplayed.value ?
                    optionDisplayed.sink.add(false):
                    optionDisplayed.sink.add(true);
                    },
                    child: Container(
                      padding: mediumPaddingAll,
                      decoration: BoxDecoration(
                        color: whiteRed100,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: primaryColor),
                      ),
                      child:Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const [
                           Text("Do you have a medical insurance ? "),
                          Icon(Icons.arrow_drop_down,color: blackColor,)
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 2.h,
                  ),
                  StreamBuilder<bool>(
                    stream: optionDisplayed.stream,
                    builder: (context, snapshot) {
                      return optionDisplayed.value ?
                       Visibility(
                        visible: optionDisplayed.value,
                        child: Container(
                          padding: smallPaddingAll,
                          margin: smallPaddingH,
                          height: 80.h,
                          decoration: BoxDecoration(
                              border: Border.all(width: .2),
                              color: Colors.white , borderRadius: BorderRadius.circular(8)),
                          child: StreamBuilder<int>(
                            stream: insuranceOption.stream,
                            builder: (context, snapshot) {
                              return Column(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children:insuranceChoices.map((e) => Padding(
                                  padding: smallPaddingAll,
                                  child:
                                  GestureDetector(
                                    onTap : ()
                                    {
                                     insuranceOption.sink.add(insuranceChoices.indexOf(e));
                                    },
                                    child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(e.hasInsurance? AppLocalizations.of(context)!.yes
                                        : AppLocalizations.of(context)!.no),
                                        insuranceOption.value == insuranceChoices.indexOf(e)  ?
                                        const Icon(Icons.radio_button_checked):const Icon(Icons.circle_outlined)
                                      ],
                                    ),
                                  ),
                                )).toList(),
                              );
                            }
                          ),

                        ),
                      ):
                       SizedBox(height: 80.h,);
                    }
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  PrimaryButton(onPressed: (){
                  },
                    text: AppLocalizations.of(context)!.sign_up,
                  ),
                  buildSignInApps(),
                  buildSignUp()
                ],
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
            width: loginAllAnotherAppsWidth,
            alignment: AlignmentDirectional.center,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.max,
              children: [
                buildApp(googleIcon),
                buildApp(facebookIcon),
                buildApp(twitterIcon),
              ],
            ),
          )
        ],
      ),
    );
  }
  buildApp(String image) {
    return Container(
      width: loginAnotherAppsWidth,
      height: loginAnotherAppsHeight,
      alignment: AlignmentDirectional.center,
      margin: const EdgeInsets.only(top: loginAnotherAppsMarginTop),
      decoration: const BoxDecoration(
          color: whiteColor,
          borderRadius:
          BorderRadius.all(Radius.circular(loginAnotherAppsRadius)),
          boxShadow: [
            BoxShadow(
              blurRadius: 9,
              spreadRadius: -1,
              color: shadowColor,
            )
          ]),
      child: Image.asset(
        image,
        width: loginAnotherAppsIconWidth,
        height: loginAnotherAppsIconHeight,
      ),
    );
  }

  navigateToLoginScreen() {
    Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => const LoginScreen()));

  }


}
