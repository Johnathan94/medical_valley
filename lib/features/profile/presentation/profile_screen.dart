import 'package:cool_alert/cool_alert.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';
import 'package:intl_phone_field/countries.dart';
import 'package:medical_valley/core/app_colors.dart';
import 'package:medical_valley/core/app_paddings.dart';
import 'package:medical_valley/core/app_styles.dart';
import 'package:medical_valley/core/dialogs/loading_dialog.dart';
import 'package:medical_valley/core/strings/images.dart';
import 'package:medical_valley/core/widgets/GenericITextField.dart';
import 'package:medical_valley/core/widgets/custom_app_bar.dart';
import 'package:medical_valley/core/widgets/phone_intl_widget.dart';
import 'package:medical_valley/core/widgets/primary_button.dart';
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
  TextEditingController nationalIdController = TextEditingController();
  final UserProfileBloc _bloc = GetIt.instance<UserProfileBloc>();
  BehaviorSubject<String> genderDisplayed = BehaviorSubject();
  BehaviorSubject<String> optionDisplayed = BehaviorSubject();
  final formKey = GlobalKey<FormState>();
  @override
  void initState() {
    _bloc.getUserData();
    super.initState();
  }

  @override
  void didChangeDependencies() {
    genderDisplayed.sink.add(AppLocalizations.of(context)!.male);
    optionDisplayed.sink.add(AppLocalizations.of(context)!.male);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: whiteColor,
        appBar: MyCustomAppBar(
          header: AppLocalizations.of(context)!.medical_file,
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
                phoneController.text = state.model.mobile ?? "";
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
                                    type: CoolAlertType.success,
                                    text: AppLocalizations.of(context)!
                                        .profile_data_saved,
                                  );
                                } else {
                                  UpdateUserInfoStateError myState =
                                      (state as UpdateUserInfoStateError);
                                  LoadingDialogs.hideLoadingDialog();
                                  CoolAlert.show(
                                    context: context,
                                    autoCloseDuration:
                                        const Duration(seconds: 1),
                                    type: CoolAlertType.error,
                                    text: myState.error,
                                  );
                                }
                              }),
                          Image.asset(personImage),
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
                          GenericTextField(
                            fillColor: textFieldBg,
                            textController: nationalIdController,
                            hintText: AppLocalizations.of(context)!.national_id,
                            hintStyle: AppStyles
                                .baloo2FontWith400WeightAnd14Size
                                .copyWith(color: darkGrey),
                          ),
                          SizedBox(
                            height: 17.h,
                          ),
                          PhoneIntlWidgetField(
                            phoneController,
                            (Country country) {},
                            fillColor: textFieldBg,
                            borderColor: Colors.transparent,
                          ),
                          SizedBox(
                            height: 17.h,
                          ),
                          GestureDetector(
                            onTap: () => _showCalender(),
                            child: GenericTextField(
                              fillColor: textFieldBg,
                              textController: birthDateController,
                              isEnabled: false,
                              hintText:
                                  AppLocalizations.of(context)!.date_of_birth,
                              hintStyle: AppStyles
                                  .baloo2FontWith400WeightAnd14Size
                                  .copyWith(color: darkGrey),
                              suffixIcon: const Icon(
                                Icons.calendar_month_outlined,
                                color: darkGrey,
                              ),
                            ),
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
        onPressed: () {
          _bloc.updateUserData(UpdateUserRequest(
              id: model.id,
              fullName: fullNameController.text,
              email: emailController.text,
              nationalId: nationalIdController.text,
              birthDate: birthDateController.text,
              genderId:
                  genderDisplayed.value == AppLocalizations.of(context)!.male
                      ? 1
                      : 2,
              location: '',
              latitude: 0,
              longitude: 0));
        },
      ),
    );
  }

  void _showCalender() async {
    DateTime? selected = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2022),
        lastDate: DateTime(2050));
    if (selected != null) {
      birthDateController.text = DateFormat("dd-MM-yyyy").format(selected);
    }
  }
}
