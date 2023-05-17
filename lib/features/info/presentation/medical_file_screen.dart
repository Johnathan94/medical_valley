import 'package:cool_alert/cool_alert.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it/get_it.dart';
import 'package:medical_valley/core/app_colors.dart';
import 'package:medical_valley/core/app_paddings.dart';
import 'package:medical_valley/core/app_styles.dart';
import 'package:medical_valley/core/dialogs/loading_dialog.dart';
import 'package:medical_valley/core/shared_pref/shared_pref.dart';
import 'package:medical_valley/core/strings/images.dart';
import 'package:medical_valley/core/widgets/GenericITextField.dart';
import 'package:medical_valley/core/widgets/custom_app_bar.dart';
import 'package:medical_valley/core/widgets/primary_button.dart';
import 'package:medical_valley/core/widgets/snackbars.dart';
import 'package:medical_valley/features/auth/phone_verification/data/model/otp_response_model.dart';
import 'package:medical_valley/features/info/data/medical_file_request.dart';
import 'package:medical_valley/features/info/data/medical_file_response.dart';
import 'package:medical_valley/features/info/presentation/bloc/medical_file_bloc.dart';
import 'package:medical_valley/features/welcome_page/presentation/screens/welcome_page_screen.dart';
import 'package:rxdart/subjects.dart';

class MedicalFileScreen extends StatefulWidget {
  final bool openFirstTime;
  const MedicalFileScreen({required this.openFirstTime, Key? key})
      : super(key: key);

  @override
  State<MedicalFileScreen> createState() => _MedicalFileScreenState();
}

class _MedicalFileScreenState extends State<MedicalFileScreen> {
  TextEditingController fullNameController = TextEditingController();
  TextEditingController notesController = TextEditingController();
  TextEditingController birthDateController = TextEditingController();
  TextEditingController genderController = TextEditingController();
  TextEditingController nationalIdController = TextEditingController();
  final MedicalFileBloc _bloc = GetIt.instance<MedicalFileBloc>();
  BehaviorSubject<String> genderDisplayed = BehaviorSubject();
  BehaviorSubject<String> optionDisplayed = BehaviorSubject();
  final _formKey = GlobalKey<FormState>();
  late UserDate user;

  @override
  void initState() {
    _bloc.getMedicalFile();
    user = UserDate.fromJson(LocalStorageManager.getUser()!);

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
        body: BlocBuilder<MedicalFileBloc, MedicalInfoState>(
            bloc: _bloc,
            buildWhen: (pre, cur) {
              return cur is MedicalInfoStateLoading ||
                  cur is MedicalInfoStateSuccess ||
                  cur is MedicalInfoStateError;
            },
            builder: (context, state) {
              if (state is MedicalInfoStateLoading) {
                return const Center(
                  child: CircularProgressIndicator(
                    color: primaryColor,
                  ),
                );
              } else if (state is MedicalInfoStateSuccess) {
                fullNameController.text = state.model.fullName ?? "";
                nationalIdController.text = state.model.nationalId ?? "";
                genderDisplayed.sink.add(state.model.genderStr ??
                    AppLocalizations.of(context)!.male);
                birthDateController.text = state.model.birthDate ?? "";
                notesController.text = state.model.notes ?? "";
                return Padding(
                  padding: bigPaddingHV,
                  child: SingleChildScrollView(
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          BlocListener(
                              bloc: _bloc,
                              child: const SizedBox(),
                              listenWhen: (pre, cur) {
                                return cur is SetMedicalInfoStateLoading ||
                                    cur is SetMedicalInfoStateSuccess ||
                                    cur is SetMedicalInfoStateError;
                              },
                              listener: (c, state) async {
                                if (state is SetMedicalInfoStateLoading) {
                                  await LoadingDialogs.showLoadingDialog(
                                      context);
                                } else if (state
                                    is SetMedicalInfoStateSuccess) {
                                  LoadingDialogs.hideLoadingDialog();
                                  CoolAlert.show(
                                    barrierDismissible: false,
                                    context: context,
                                    autoCloseDuration:
                                        const Duration(seconds: 1),
                                    type: CoolAlertType.success,
                                    text: AppLocalizations.of(context)!
                                        .success_login,
                                  );
                                  if (widget.openFirstTime) {
                                    Future.delayed(const Duration(seconds: 2),
                                        () {
                                      Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                              builder: (c) =>
                                                  const WelcomePageScreen()));
                                    });
                                  }
                                } else {
                                  SetMedicalInfoStateError myState =
                                      (state as SetMedicalInfoStateError);
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
                            textController: birthDateController,
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
                            height: 17.h,
                          ),
                          GenericTextField(
                            fillColor: textFieldBg,
                            onValidator: (String? text) {
                              if (text!.isNotEmpty && text.length <= 14) {
                                return null;
                              } else {
                                return AppLocalizations.of(context)!
                                    .national_id_is_required;
                              }
                            },
                            textController: nationalIdController,
                            hintText: AppLocalizations.of(context)!.national_id,
                            hintStyle: AppStyles
                                .baloo2FontWith400WeightAnd14Size
                                .copyWith(color: darkGrey),
                          ),
                          SizedBox(
                            height: 17.h,
                          ),
                          GenericTextField(
                            fillColor: whiteColor,
                            maxLines: 4,
                            enabledBorder: OutlineInputBorder(
                                borderSide: const BorderSide(color: darkGrey),
                                borderRadius: BorderRadius.circular(8)),
                            textController: notesController,
                            hintText: AppLocalizations.of(context)!.notes,
                            hintStyle: AppStyles
                                .baloo2FontWith400WeightAnd14Size
                                .copyWith(color: darkGrey),
                          ),
                          SizedBox(
                            height: 30.h,
                          ),
                          paymentButton(state.model)
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

  paymentButton(MedicalFileModel model) {
    return Padding(
      padding: const EdgeInsetsDirectional.only(top: 10.0, start: 10, end: 10),
      child: PrimaryButton(
        text: AppLocalizations.of(context)!.payment,
        onPressed: () {
          if (_formKey.currentState!.validate()) {
            _bloc.setMedicalFile(MedicalFileRequest(
                id: model.id,
                hasInsurance: user.hasInsurance ?? model.hasInsurance,
                nationalId: nationalIdController.text,
                insuranceNumber: model.insuranceNumber,
                birthDate: birthDateController.text,
                genderId:
                    genderDisplayed.value == AppLocalizations.of(context)!.male
                        ? 1
                        : 2));
          } else {
            context.showSnackBar(
                AppLocalizations.of(context)!.please_fill_all_data);
          }
        },
      ),
    );
  }
}
