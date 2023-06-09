import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it/get_it.dart';
import 'package:medical_valley/core/app_colors.dart';
import 'package:medical_valley/core/app_paddings.dart';
import 'package:medical_valley/core/dialogs/loading_dialog.dart';
import 'package:medical_valley/core/shared_pref/shared_pref.dart';
import 'package:medical_valley/features/auth/phone_verification/data/model/otp_response_model.dart';
import 'package:medical_valley/features/home/home_screen/data/book_request_model.dart';
import 'package:medical_valley/features/home/home_screen/persentation/bloc/book_request_bloc.dart';
import 'package:medical_valley/features/offers/presentation/offers_screen.dart';
import 'package:rxdart/rxdart.dart';

import '../../../../../core/widgets/primary_button.dart';
import '../../../home_search_screen/data/models/services_model.dart';

class CalenderScreen extends StatefulWidget {
  final Service services;
  final bool isProviderService;

  const CalenderScreen(
      {required this.services, required this.isProviderService, Key? key})
      : super(key: key);

  @override
  State<CalenderScreen> createState() => _CalenderScreenState();
}

class _CalenderScreenState extends State<CalenderScreen> {
  List<DateTime?> _singleDatePickerValueWithDefaultValue = [
    DateTime.now(),
  ];
  BehaviorSubject<String> selectedSlot =
      BehaviorSubject<String>.seeded("09:00");

  TextEditingController notesController = TextEditingController();
  BookRequestBloc bookRequestBloc = GetIt.I<BookRequestBloc>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(AppLocalizations.of(context)!.schedule_an_appointment),
          leading: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: const Icon(Icons.close)),
        ),
        body: BlocListener<BookRequestBloc, BookRequestState>(
          bloc: bookRequestBloc,
          listener: (context, state) {
            if (state.state == BookedState.loading) {
              LoadingDialogs.showLoadingDialog(context);
            } else if (state.state == BookedState.success) {
              LoadingDialogs.hideLoadingDialog();
              CoolAlert.show(
                barrierDismissible: false,
                context: context,
                autoCloseDuration: const Duration(seconds: 1),
                type: CoolAlertType.success,
                text: AppLocalizations.of(context)!.booked_successed,
              );
              Future.delayed(const Duration(seconds: 2), () async {
                Navigator.pop(context);
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (c) => OffersScreen(
                              requestId: state.requestId!,
                            )));
              });
            } else {
              LoadingDialogs.hideLoadingDialog();
              CoolAlert.show(
                barrierDismissible: false,
                context: context,
                autoCloseDuration: const Duration(seconds: 1),
                type: CoolAlertType.error,
                text: AppLocalizations.of(context)!.something_went_wrong,
              );
              Future.delayed(const Duration(seconds: 2), () async {
                Navigator.pop(context);
              });
            }
          },
          child: _buildDefaultSingleDatePickerWithValue(),
        ));
  }

  Widget _buildDefaultSingleDatePickerWithValue() {
    final config = CalendarDatePicker2Config(
      selectedDayHighlightColor: primaryColor,
      weekdayLabels: ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'],
      weekdayLabelTextStyle: const TextStyle(
        color: Colors.black87,
        fontWeight: FontWeight.bold,
      ),
      firstDayOfWeek: 1,
      controlsHeight: 50,
      controlsTextStyle: const TextStyle(
        color: Colors.black,
        fontSize: 15,
        fontWeight: FontWeight.bold,
      ),
      dayTextStyle: const TextStyle(
        color: Colors.black,
        fontWeight: FontWeight.bold,
      ),
      disabledDayTextStyle: const TextStyle(
        color: Colors.red,
      ),
      selectableDayPredicate: (day) => !day
          .difference(DateTime.now().subtract(const Duration(days: 3)))
          .isNegative,
    );
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        const SizedBox(height: 10),
        CalendarDatePicker2(
          config: config,
          initialValue: _singleDatePickerValueWithDefaultValue,
          onValueChanged: (values) =>
              setState(() => _singleDatePickerValueWithDefaultValue = values),
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(width: 10),
            Text(
              _getValueText(
                config.calendarType,
                _singleDatePickerValueWithDefaultValue,
              ),
            ),
          ],
        ),
        const SizedBox(height: 25),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: TextFormField(
            minLines: 3,
            maxLines: 10,
            // user keyboard will have a button to move cursor to next line
            controller: notesController,
            decoration:
                InputDecoration(hintText: AppLocalizations.of(context)!.notes),
          ),
        ),
        Container(
          margin: mediumPaddingHV.r,
          child: PrimaryButton(
            onPressed: () {
              UserDate result =
                  UserDate.fromJson(LocalStorageManager.getUser()!);
              bookRequestBloc.sendRequest(BookRequestModel(
                  serviceId: widget.services.id!,
                  categoryId: widget.services.categoryId!,
                  bookingTypeId: 3,
                  userId: result.id!,
                  isProviderService: widget.isProviderService,
                  appointmentDate: _getValueText(
                    config.calendarType,
                    _singleDatePickerValueWithDefaultValue,
                  ),
                  appointmentTime: selectedSlot.value,
                  notes: notesController.text));
            },
            text: AppLocalizations.of(context)!.send_request,
          ),
        ),
      ],
    );
  }

  String _getValueText(
    CalendarDatePicker2Type datePickerType,
    List<DateTime?> values,
  ) {
    var valueText = (values.isNotEmpty ? values[0] : null)
        .toString()
        .replaceAll('00:00:00.000', '');

    if (datePickerType == CalendarDatePicker2Type.multi) {
      valueText = values.isNotEmpty
          ? values
              .map((v) => v.toString().replaceAll('00:00:00.000', ''))
              .join(', ')
          : 'null';
    } else if (datePickerType == CalendarDatePicker2Type.range) {
      if (values.isNotEmpty) {
        final startDate = values[0].toString().replaceAll('00:00:00.000', '');
        final endDate = values.length > 1
            ? values[1].toString().replaceAll('00:00:00.000', '')
            : 'null';
        valueText = '$startDate to $endDate';
      } else {
        return 'null';
      }
    }

    return valueText;
  }
}
