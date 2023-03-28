import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medical_valley/core/app_colors.dart';
import 'package:medical_valley/core/app_paddings.dart';
import 'package:medical_valley/core/app_sizes.dart';
import 'package:medical_valley/core/app_styles.dart';
import 'package:medical_valley/core/dialogs/loading_dialog.dart';
import 'package:medical_valley/core/shared_pref/shared_pref.dart';
import 'package:medical_valley/core/strings/images.dart';
import 'package:medical_valley/core/widgets/change_language_screen/peresentation/blocks/chnage_language_block.dart';
import 'package:medical_valley/core/widgets/primary_button.dart';
import 'package:medical_valley/features/auth/login/presentation/screens/login_screen.dart';
import 'package:medical_valley/features/home/more_screen/widget/profile_image.dart';

import '../../../../core/widgets/change_language_screen/peresentation/screens/change_language_screen.dart';

class MoreScreen extends StatelessWidget {
  const MoreScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Stack(
            children: [
              Container(
                alignment: Alignment.bottomRight,
                width: screenWidth,
                height: 230.h,
                decoration: const BoxDecoration(color: primaryColor),
                child: Image.asset("${imagesPath}transparent_app_icon.png"),
              ),
              Container(
                alignment: Alignment.center,
                width: screenWidth,
                height: 270.h,
                decoration: const BoxDecoration(color: Colors.transparent),
                child: const ProfileImage(),
              ),
            ],
          ),
          Padding(
            padding: mediumPaddingHV.copyWith(top: 24.h),
            child: Container(
              padding: smallPaddingHV,
              decoration: BoxDecoration(
                  color: whiteColor,
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: const [
                    BoxShadow(
                        blurRadius: 10,
                        spreadRadius: 2,
                        color: greyWith80Percentage,
                        offset: Offset(1, 2))
                  ]),
              child: Column(
                children: [
                  ListTile(
                    leading: const IconBG(
                      color: Color(0xff4780A8),
                      image: Icons.notifications,
                    ),
                    title: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          AppLocalizations.of(context)!.notifications,
                          style: AppStyles.baloo2FontWith400WeightAnd14Size
                              .copyWith(
                            color: blackColor,
                          ),
                        ),
                        Text(
                          AppLocalizations.of(context)!.manage_notifications,
                          style: AppStyles.baloo2FontWith400WeightAnd12Size
                              .copyWith(color: greyWith80Percentage),
                        ),
                      ],
                    ),
                    trailing: Switch.adaptive(
                      value: true,
                      onChanged: (bool value) {},
                    ),
                  ),
                  const Divider(
                    color: dividerGrey,
                    indent: 8,
                    endIndent: 8,
                  ),
                  ListTile(
                    leading: const IconBG(
                      color: Color(0xff4780A8),
                      image: Icons.email_outlined,
                    ),
                    title: Text(
                      AppLocalizations.of(context)!.messages,
                      style: AppStyles.baloo2FontWith400WeightAnd14Size
                          .copyWith(color: blackColor),
                    ),
                    trailing: Switch.adaptive(
                      value: true,
                      onChanged: (bool value) {},
                    ),
                  ),
                  const Divider(
                    color: dividerGrey,
                    indent: 8,
                    endIndent: 8,
                  ),
                  ListTile(
                    leading: const IconBG(
                      color: Color(0xffF08A5D),
                      image: Icons.language,
                    ),
                    title: Text(
                      AppLocalizations.of(context)!.languages,
                      style: AppStyles.baloo2FontWith400WeightAnd14Size
                          .copyWith(color: blackColor),
                    ),
                    trailing: const Icon(
                      Icons.arrow_forward_ios,
                      color: greyWith80Percentage,
                    ),
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => BlocProvider(
                                create: (context) => LanguageBloc(),
                                child: const ChangeLanguageScreen(),
                              )));
                    },
                  ),
                  const Divider(
                    color: dividerGrey,
                    indent: 8,
                    endIndent: 8,
                  ),
                  ListTile(
                    leading: const IconBG(
                      color: Color(0xffFE01C3),
                      image: Icons.list_alt_rounded,
                    ),
                    title: Text(
                      AppLocalizations.of(context)!.terms_and_privacy,
                      style: AppStyles.baloo2FontWith400WeightAnd14Size
                          .copyWith(color: blackColor),
                    ),
                    trailing: const Icon(
                      Icons.arrow_forward_ios,
                      color: greyWith80Percentage,
                    ),
                  ),
                  const Divider(
                    color: dividerGrey,
                    indent: 8,
                    endIndent: 8,
                  ),
                  ListTile(
                    leading: const IconBG(
                      color: Color(0xffF15C5C),
                      image: Icons.call,
                    ),
                    title: Text(
                      AppLocalizations.of(context)!.contact_us,
                      style: AppStyles.baloo2FontWith400WeightAnd14Size
                          .copyWith(color: blackColor),
                    ),
                    trailing: const Icon(
                      Icons.arrow_forward_ios,
                      color: greyWith80Percentage,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: mediumPaddingHV,
            child: PrimaryButton(
              buttonCornerRadius: 22,
              onPressed: () async{
                LoadingDialogs.showLoadingDialog(context);
               await LocalStorageManager.remove();
               LoadingDialogs.hideLoadingDialog();
               CoolAlert.show(
                 barrierDismissible: false,
                 context: context,
                 autoCloseDuration: const Duration(seconds: 1),
                 type: CoolAlertType.success,
                 text: AppLocalizations.of(context)!.success_logout,
               );
               Future.delayed(const Duration(seconds: 2), ()async{
                 await LocalStorageManager.deleteUser();
                 Navigator.push(context, MaterialPageRoute(builder: (c)=>LoginScreen()));
               });
              },
              text: AppLocalizations.of(context)!.sign_out,
            ),
          ),
        ],
      ),
    );
  }
}

class IconBG extends StatelessWidget {
  final Color color;
  final IconData image;
  const IconBG({required this.color, required this.image, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: tinyPaddingAll,
      decoration:
          BoxDecoration(color: color, borderRadius: BorderRadius.circular(8)),
      child: Icon(
        image,
        color: whiteColor,
        size: 25,
      ),
    );
  }
}
