import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:dio/dio.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it/get_it.dart';
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:intl_phone_field/countries.dart';
import 'package:medical_valley/core/app_colors.dart';
import 'package:medical_valley/core/app_paddings.dart';
import 'package:medical_valley/core/app_styles.dart';
import 'package:medical_valley/core/dialogs/loading_dialog.dart';
import 'package:medical_valley/core/shared_pref/shared_pref.dart';
import 'package:medical_valley/core/strings/images.dart';
import 'package:medical_valley/core/widgets/GenericITextField.dart';
import 'package:medical_valley/core/widgets/custom_app_bar.dart';
import 'package:medical_valley/core/widgets/phone_intl_widget.dart';
import 'package:medical_valley/core/widgets/primary_button.dart';
import 'package:medical_valley/features/auth/phone_verification/data/model/otp_response_model.dart';
import 'package:medical_valley/features/home/home_screen/persentation/screens/home_screen.dart';
import 'package:medical_valley/features/profile/data/edit_user_request.dart';
import 'package:medical_valley/features/profile/data/get_user_response.dart';
import 'package:medical_valley/features/profile/presentation/bloc/user_profile_bloc.dart';
import 'package:rxdart/subjects.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  TextEditingController fullNameController = TextEditingController();
  TextEditingController notesController = TextEditingController();
  TextEditingController birthDateController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  final UserProfileBloc _bloc = GetIt.instance<UserProfileBloc>();
  BehaviorSubject<String> genderDisplayed = BehaviorSubject();
  BehaviorSubject<String> optionDisplayed = BehaviorSubject();
  final formKey = GlobalKey<FormState>();
  BehaviorSubject<String> insuranceDisplayed = BehaviorSubject();
  late String phoneNumber;
  @override
  void initState() {
    _bloc.getUserData();
    super.initState();
  }

  late File _imageFile;
  BehaviorSubject<File> imageFileSubject = BehaviorSubject();

  Future<void> _pickImage(ImageSource source) async {
    final picker = ImagePicker();
    final pickedImage = await picker.getImage(source: source);

    if (pickedImage != null) {
      _imageFile = File(pickedImage.path);
      imageFileSubject.sink.add(_imageFile);
    }
  }

  @override
  void didChangeDependencies() {
    insuranceDisplayed.sink.add(AppLocalizations.of(context)!.yes);
    genderDisplayed.sink.add(AppLocalizations.of(context)!.male);
    optionDisplayed.sink.add(AppLocalizations.of(context)!.male);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: whiteColor,
        appBar: MyCustomAppBar(
          header: AppLocalizations.of(context)!.profile,
          leadingIcon: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: const Icon(Icons.arrow_back_ios)),
        ),
        body: BlocBuilder<UserProfileBloc, UserInfoState>(
            bloc: _bloc,
            buildWhen: (pre, cur) {
              return cur is GetUserInfoStateLoading ||
                  cur is GetUserInfoStateSuccess ||
                  cur is GetUserInfoStateError;
            },
            builder: (context, state) {
              if (state is GetUserInfoStateLoading) {
                return const Center(
                  child: CircularProgressIndicator(
                    color: primaryColor,
                  ),
                );
              } else if (state is GetUserInfoStateSuccess) {
                fullNameController.text = state.model.fullName ?? "";
                genderDisplayed.sink.add(state.model.genderStr != null
                    ? toGenderLocal(state.model.genderStr!)
                    : AppLocalizations.of(context)!.male);
                optionDisplayed.sink.add(state.model.genderStr ??
                    AppLocalizations.of(context)!.male);
                notesController.text = state.model.notes ?? "";
                emailController.text = state.model.email ?? "";
                phoneNumber = state.model.mobile ?? "";
                phoneController.text =
                    seperatePhoneAndDialCode("+$phoneNumber")[1];
                insuranceDisplayed.sink.add(state.model.hasInsurance != null &&
                        state.model.hasInsurance!
                    ? AppLocalizations.of(context)!.yes
                    : AppLocalizations.of(context)!.no);
                optionDisplayed.sink.add(state.model.hasInsurance != null &&
                        state.model.hasInsurance!
                    ? AppLocalizations.of(context)!.yes
                    : AppLocalizations.of(context)!.no);

                return Padding(
                  padding: bigPaddingHV,
                  child: SingleChildScrollView(
                    child: Form(
                      key: formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          BlocListener(
                              bloc: _bloc,
                              child: const SizedBox(),
                              listenWhen: (pre, cur) {
                                return cur is UpdateUserInfoStateLoading ||
                                    cur is UpdateUserInfoStateSuccess ||
                                    cur is UpdateUserInfoStateError;
                              },
                              listener: (c, state) async {
                                if (state is UpdateUserInfoStateLoading) {
                                  await LoadingDialogs.showLoadingDialog(
                                      context);
                                } else if (state
                                    is UpdateUserInfoStateSuccess) {
                                  LoadingDialogs.hideLoadingDialog();
                                  CoolAlert.show(
                                    barrierDismissible: false,
                                    context: context,
                                    autoCloseDuration:
                                        const Duration(seconds: 1),
                                    showOkBtn: false,
                                    type: CoolAlertType.success,
                                    title:
                                        AppLocalizations.of(context)!.success,
                                    text: AppLocalizations.of(context)!
                                        .profile_data_saved,
                                  );
                                  var userDate = UserDate.fromJson(
                                      LocalStorageManager.getUser()!);
                                  userDate.fullName = fullNameController.text;
                                  userDate.email = emailController.text;
                                  LocalStorageManager.saveUser(
                                      userDate.toJson());
                                } else {
                                  UpdateUserInfoStateError myState =
                                      (state as UpdateUserInfoStateError);
                                  LoadingDialogs.hideLoadingDialog();
                                  CoolAlert.show(
                                    context: context,
                                    type: CoolAlertType.error,
                                    title: AppLocalizations.of(context)!.error,
                                    text: myState.error,
                                    autoCloseDuration:
                                        const Duration(seconds: 1),
                                    showOkBtn: false,
                                    closeOnConfirmBtnTap: true,
                                  );
                                }
                              }),
                          Stack(
                            children: [
                              StreamBuilder<File>(
                                  stream: imageFileSubject.stream,
                                  builder: (context, snapshot) {
                                    return imageFileSubject.hasValue
                                        ? Container(
                                            width: 120,
                                            height: 120,
                                            decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: Colors.red,
                                                image: DecorationImage(
                                                    fit: BoxFit.fill,
                                                    image: FileImage(
                                                        imageFileSubject
                                                            .value))),
                                          )
                                        : state.model.userAvatar != null
                                            ? CachedNetworkImage(
                                                imageUrl: iconLinkPrefix +
                                                    state.model.userAvatar!,
                                                imageBuilder:
                                                    (context, imageProvider) =>
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
                                                errorWidget:
                                                    (context, url, error) =>
                                                        Container(
                                                  decoration:
                                                      const BoxDecoration(
                                                          image:
                                                              DecorationImage(
                                                    fit: BoxFit.fill,
                                                    image:
                                                        AssetImage(personImage),
                                                  )),
                                                ),
                                                width: 120,
                                                height: 120,
                                              )
                                            : Image.asset(personImage);
                                  }),
                              PositionedDirectional(
                                end: 10,
                                bottom: 10,
                                child: GestureDetector(
                                  onTap: () {
                                    _pickImage(ImageSource.gallery);
                                  },
                                  child: const Icon(
                                    Icons.edit_calendar_outlined,
                                    color: primaryColor,
                                  ),
                                ),
                              )
                            ],
                          ),
                          SizedBox(
                            height: 30.h,
                          ),
                          GenericTextField(
                            fillColor: textFieldBg,
                            textController: fullNameController,
                            hintText: AppLocalizations.of(context)!.fullname,
                            hintStyle: AppStyles
                                .baloo2FontWith400WeightAnd14Size
                                .copyWith(color: darkGrey),
                          ),
                          SizedBox(
                            height: 17.h,
                          ),
                          GenericTextField(
                            fillColor: textFieldBg,
                            textController: emailController,
                            hintText: AppLocalizations.of(context)!.email,
                            hintStyle: AppStyles
                                .baloo2FontWith400WeightAnd14Size
                                .copyWith(color: darkGrey),
                          ),
                          SizedBox(
                            height: 17.h,
                          ),
                          PhoneIntlWidgetField(
                            phoneController,
                            false,
                            countryCode:
                                seperatePhoneAndDialCode("+$phoneNumber")[0],
                            (Country country) {},
                            fillColor: textFieldBg,
                            borderColor: Colors.transparent,
                          ),
                          SizedBox(
                            height: 17.h,
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
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                    item,
                                                    style: const TextStyle(
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.black,
                                                    ),
                                                    overflow:
                                                        TextOverflow.ellipsis,
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
                                      optionDisplayed.sink.add(value);
                                    },
                                    icon: const Padding(
                                      padding:
                                          EdgeInsetsDirectional.only(end: 8.0),
                                      child:
                                          Icon(Icons.arrow_drop_down_outlined),
                                    ),
                                    buttonHeight: 60,
                                    underline: const SizedBox(),
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
                            height: 17.h,
                          ),
                          StreamBuilder<String>(
                              stream: insuranceDisplayed.stream,
                              builder: (context, snapshot) {
                                return SizedBox(
                                  width: MediaQuery.of(context).size.width,
                                  child: DropdownButton2<String>(
                                    isExpanded: true,
                                    hint: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Flexible(
                                          child: Text(
                                            AppLocalizations.of(context)!
                                                .insurance_question,
                                            style: AppStyles.headlineStyle,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                        Text(
                                          insuranceDisplayed.value,
                                          style: AppStyles.headlineStyle,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ],
                                    ),
                                    items: [
                                      AppLocalizations.of(context)!.yes,
                                      AppLocalizations.of(context)!.no,
                                    ]
                                        .map((item) => DropdownMenuItem<String>(
                                              value: item,
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                    item,
                                                    style: const TextStyle(
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.black,
                                                    ),
                                                    overflow:
                                                        TextOverflow.ellipsis,
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
                                      insuranceDisplayed.sink.add(value!);
                                      optionDisplayed.sink.add(value);
                                    },
                                    icon: const Padding(
                                      padding:
                                          EdgeInsetsDirectional.only(end: 8.0),
                                      child:
                                          Icon(Icons.arrow_drop_down_outlined),
                                    ),
                                    buttonHeight: 60,
                                    underline: const SizedBox(),
                                    buttonDecoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8),
                                        color: textFieldBg,
                                        border:
                                            Border.all(color: primaryColor)),
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
                            height: 30.h,
                          ),
                          updateButton(state.model)
                        ],
                      ),
                    ),
                  ),
                );
              } else {
                return Center(
                  child: Text(AppLocalizations.of(context)!.there_is_no_data),
                );
              }
            }));
  }

  String toGenderLocal(String gender) {
    switch (gender.toLowerCase().trim()) {
      case "male":
        return AppLocalizations.of(context)!.male;
      default:
        return AppLocalizations.of(context)!.female;
    }
  }

  updateButton(UserModel model) {
    return Padding(
      padding: const EdgeInsetsDirectional.only(top: 10.0, start: 10, end: 10),
      child: PrimaryButton(
        text: AppLocalizations.of(context)!.edit_user,
        onPressed: () async {
          if (imageFileSubject.hasValue) {
            MultipartFile? image = await MultipartFile.fromFile(
                imageFileSubject.value.path,
                filename: "${model.id}_picture",
                contentType: MediaType("image", "jpeg"));
            _bloc.updateUserData(
                UpdateUserRequest(
                  id: model.id,
                  fullName: fullNameController.text,
                  email: emailController.text,
                  genderId: genderDisplayed.value ==
                          AppLocalizations.of(context)!.male
                      ? 1
                      : 2,
                  haveInsurance: insuranceDisplayed.value ==
                          AppLocalizations.of(context)!.yes
                      ? true
                      : false,
                  location: '',
                  latitude: 0,
                  longitude: 0,
                ),
                image);
          } else {
            _bloc.updateUserData(UpdateUserRequest(
              id: model.id,
              fullName: fullNameController.text,
              email: emailController.text,
              genderId:
                  genderDisplayed.value == AppLocalizations.of(context)!.male
                      ? 1
                      : 2,
              haveInsurance:
                  insuranceDisplayed.value == AppLocalizations.of(context)!.yes
                      ? true
                      : false,
              location: '',
              latitude: 0,
              longitude: 0,
            ));
          }
        },
      ),
    );
  }

  void _showCalender() async {
    DateTime? selected = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1900),
        lastDate: DateTime(2050));
    if (selected != null) {
      birthDateController.text = DateFormat("dd-MM-yyyy").format(selected);
    }
  }
}
