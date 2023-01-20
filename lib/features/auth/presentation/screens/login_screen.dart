import 'package:flutter/material.dart';
import 'package:medical_valley/core/app_styles.dart';
import 'package:medical_valley/core/strings/images.dart';
import 'package:medical_valley/core/strings/messages.dart';
import 'package:medical_valley/core/widgets/phone_intl_widget.dart';
import 'package:medical_valley/core/widgets/primary_button.dart';
import 'package:medical_valley/features/phone_verification/persentation/screens/phone_verification.dart';
import 'package:medical_valley/features/register/presentation/registeration_screen.dart';
import 'package:rxdart/rxdart.dart';
import '../../../../core/app_colors.dart';
import '../../../../core/app_sizes.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  BehaviorSubject<bool> _checkBoxBehaviourSubject = BehaviorSubject<bool>();

  @override
  initState() {
    _checkBoxBehaviourSubject.sink.add( false);
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
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        color: primaryColor,
        child: Stack(
          children: [getLoginBackground(), getLoginBody()],
        ),
      ),
    );
  }

  getLoginBackground() {
    return Container(
      alignment: AlignmentDirectional.topCenter,
      margin: const EdgeInsets.only(top: loginIconMarginTop),
      child: Image.asset(
        appIcon,
        width: loginIconWidth,
        height: loginIconHeight,
      ),
    );
  }

  getLoginBody() {
    return Positioned(
        top: loginBodyMarginTop,
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: const BoxDecoration(
              color: whiteColor,
              borderRadius: BorderRadiusDirectional.only(
                  topStart: Radius.circular(loginBodyRadius))),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              buildLoginScreenTitle(),
              buildMobilePhoneField(),
              SizedBox(height: 16.h,),
              buildRememberMe(),
              PrimaryButton(onPressed: (){
                navigateToOtpScreen();
              },
              text: signInText,
              ),
              buildSignInApps(),
              buildSignUp()
            ],
          ),
        ));
  }

  buildLoginScreenTitle() {
    return Container(
      margin: const EdgeInsets.only(top: loginTitleMarginTop),
      alignment: AlignmentDirectional.center,
      child: Text(
        loginTitle,
        style: AppStyles.baloo2FontWith400WeightAnd32Size,
      ),
    );
  }

  buildMobilePhoneField() {
    return Container(
      margin: const EdgeInsetsDirectional.only(
          top: loginMobileNumberFieldMarginTop,
          start: loginMobileNumberFieldMarginHorizontal,
          end: loginMobileNumberFieldMarginHorizontal),
      child: const PhoneIntlWidgetField(),
    );
  }

  buildRememberMe() {
    return StreamBuilder<bool>(
        stream: _checkBoxBehaviourSubject.stream,
        builder: (context, snapshot) {
          return Container(
            margin: const EdgeInsetsDirectional.only(
                start: loginRememberMeMarginStart),
            transform:
                Matrix4.translationValues(0.0, loginRememberMeMarginTop, 0.0),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Checkbox(
                  value: _checkBoxBehaviourSubject.value,
                  activeColor: primaryColor,
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  onChanged: (newValue) {
                    _checkBoxBehaviourSubject.sink.add( newValue ?? false);
                  },
                ),
                Text(
                  rememberMeText,
                  style: AppStyles.baloo2FontWith400WeightAnd12Size,
                )
              ],
            ),
          );
        });
  }



  buildSignInApps() {
    return Container(
      margin: const EdgeInsets.only(top: loginSignInAnotherAppsTextMarginTop),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Center(
            child: Text(
              signInAnotherAppsText,
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

  buildSignUp() {
    return Container(
      margin: const EdgeInsets.only(top: loginASignUpTextMarginTop),
      alignment: AlignmentDirectional.center,
      child: InkWell(
        onTap: () => navigateToRegisterScreen(),
        child: Text.rich(TextSpan(
            style: AppStyles.baloo2FontWith500WeightAnd15Size,
            text: loginSignUpText,
            children: <InlineSpan>[
              TextSpan(
                text: signUpText,
                style:
                    AppStyles.baloo2FontWith700WeightAnd15SizeWithPrimaryColor,
              )
            ])),
      ),
    );
  }

  void navigateToRegisterScreen() {
    Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => const RegistrationScreen()));
  }

  navigateToOtpScreen() {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => const PhoneVerificationScreen()));
  }
}
