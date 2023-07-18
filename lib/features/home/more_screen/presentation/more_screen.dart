import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it/get_it.dart';
import 'package:medical_valley/core/app_colors.dart';
import 'package:medical_valley/core/app_paddings.dart';
import 'package:medical_valley/core/app_sizes.dart';
import 'package:medical_valley/core/app_styles.dart';
import 'package:medical_valley/core/dialogs/loading_dialog.dart';
import 'package:medical_valley/core/shared_pref/shared_pref.dart';
import 'package:medical_valley/core/strings/images.dart';
import 'package:medical_valley/core/terms_and_conditions/persentation/screens/terms_and_condition_screen.dart';
import 'package:medical_valley/core/widgets/change_language_screen/peresentation/blocks/chnage_language_block.dart';
import 'package:medical_valley/core/widgets/primary_button.dart';
import 'package:medical_valley/features/auth/login/presentation/screens/login_screen.dart';
import 'package:medical_valley/features/auth/phone_verification/data/model/otp_response_model.dart';
import 'package:medical_valley/features/home/contact_us/contact_us.dart';
import 'package:medical_valley/features/home/home_screen/persentation/screens/home_screen.dart';
import 'package:medical_valley/features/home/more_screen/widget/profile_image.dart';
import 'package:medical_valley/features/info/presentation/medical_file_screen.dart';
import 'package:medical_valley/features/profile/presentation/bloc/user_profile_bloc.dart';

import '../../../../core/widgets/change_language_screen/peresentation/screens/change_language_screen.dart';
import '../../../profile/presentation/profile_screen.dart';

class MoreScreen extends StatefulWidget {
  const MoreScreen({Key? key}) : super(key: key);

  @override
  State<MoreScreen> createState() => _MoreScreeenState();
}

class _MoreScreeenState extends State<MoreScreen> {
  _MoreScreeenState();
  final UserProfileBloc _bloc = GetIt.instance<UserProfileBloc>();

  @override
  void initState() {
    _bloc.getUserData();
    super.initState();
  }

  late String avatar = "";
  var userDate = UserDate.fromJson(LocalStorageManager.getUser()!);
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserProfileBloc, UserInfoState>(
        bloc: _bloc,
        buildWhen: (pre, cur) {
          return cur is GetUserInfoStateLoading ||
              cur is GetUserInfoStateSuccess ||
              cur is GetUserInfoStateError;
        },
        builder: (context, state) {
          if (state is GetUserInfoStateSuccess) {
            avatar = state.model.userAvatar ?? "";
          }
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
                      child:
                          Image.asset("${imagesPath}transparent_app_icon.png"),
                    ),
                    Container(
                      alignment: Alignment.center,
                      width: screenWidth,
                      height: 270.h,
                      decoration:
                          const BoxDecoration(color: Colors.transparent),
                      child: GestureDetector(
                          onTap: () => openMoreDialog(context),
                          child: avatar.isNotEmpty
                              ? Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    CachedNetworkImage(
                                      imageUrl: iconLinkPrefix + avatar,
                                      imageBuilder: (context, imageProvider) =>
                                          Container(
                                        width: 80.0,
                                        height: 80.0,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          image: DecorationImage(
                                              image: imageProvider,
                                              fit: BoxFit.cover),
                                        ),
                                      ),
                                      placeholder: (context, url) =>
                                          const CircularProgressIndicator(),
                                      errorWidget: (context, url, error) =>
                                          Container(
                                        decoration: const BoxDecoration(
                                            image: DecorationImage(
                                          fit: BoxFit.fill,
                                          image: AssetImage(personImage),
                                        )),
                                      ),
                                      width: 80,
                                      height: 80,
                                    ),
                                    Text(
                                      userDate.fullName ?? "",
                                      style: AppStyles
                                          .baloo2FontWith700WeightAnd25Size
                                          .copyWith(color: whiteColor),
                                    )
                                  ],
                                )
                              : const ProfileImage()),
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
                                style: AppStyles
                                    .baloo2FontWith400WeightAnd14Size
                                    .copyWith(
                                  color: blackColor,
                                ),
                              ),
                              Text(
                                AppLocalizations.of(context)!
                                    .manage_notifications,
                                style: AppStyles
                                    .baloo2FontWith400WeightAnd12Size
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
                        /* ListTile(
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
                  ),*/
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
                          onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (c) =>
                                      const TermsAndConditionsScreen())),
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
                          onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const ContactUsScreen())),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: mediumPaddingHV,
                  child: PrimaryButton(
                    buttonCornerRadius: 22,
                    onPressed: () async {
                      await LoadingDialogs.showLoadingDialog(context);
                      await LocalStorageManager.remove();
                      LocalStorageManager.deleteUser().then((value) {
                        LoadingDialogs.hideLoadingDialog();
                        Navigator.pushReplacement(context,
                            MaterialPageRoute(builder: (c) => LoginScreen()));
                      });
                    },
                    text: AppLocalizations.of(context)!.sign_out,
                  ),
                ),
              ],
            ),
          );
        });
  }

  Future<void> openMoreDialog(BuildContext context) async {
    await showDialog<void>(
        context: context,
        builder: (BuildContext context) {
          return /**/ SimpleDialog(
            children: <Widget>[
              SimpleDialogOption(
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.pop(context);
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (c) => const ProfileScreen()));
                      },
                      child: Container(
                        width: 90.w,
                        height: 90.w,
                        decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                                image: NetworkImage(
                                    "https://media.istockphoto.com/id/1300845620/vector/user-icon-flat-isolated-on-white-background-user-symbol-vector-illustration.jpg?s=612x612&w=0&k=20&c=yBeyba0hUkh14_jgv1OKqIH0CCSWU_4ckRkAoy2p73o="),
                                fit: BoxFit.cover)),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.pop(context);
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (c) => const MedicalFileScreen(
                                      openFirstTime: false,
                                    )));
                      },
                      child: Container(
                        width: 79.w,
                        height: 79.w,
                        decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                                image: AssetImage(
                                  medicalFileIcon,
                                ),
                                fit: BoxFit.cover)),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        });
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
