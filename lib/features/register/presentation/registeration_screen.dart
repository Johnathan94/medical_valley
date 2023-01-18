import 'package:flutter/material.dart';
import 'package:medical_valley/core/app_colors.dart';
import 'package:medical_valley/core/app_sizes.dart';
import 'package:medical_valley/core/widgets/app_bar.dart';
import 'package:medical_valley/features/register/widgets/primary_bg.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({Key? key}) : super(key: key);

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(header: AppLocalizations.of(context)!.sign_in , leadingIcon: const Icon(Icons.arrow_back_ios , color: whiteColor,),),
      body: Stack(
        children:  [
          const PrimaryBg(),
          buildRegisterView()
        ],
      ),
    );
  }

  buildRegisterView () {
    return Positioned(
      bottom: 0,
      child : Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height * .8,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadiusDirectional.only(
            topStart: Radius.circular(registerBodyRadius)
          )
        ),
      ),
    );
  }
}
