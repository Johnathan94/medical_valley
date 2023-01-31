import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medical_valley/core/app_colors.dart';
import 'package:medical_valley/core/app_initialized.dart';
import 'package:medical_valley/core/app_paddings.dart';
import 'package:medical_valley/core/app_styles.dart';
import 'package:medical_valley/core/medical_injection.dart';
import 'package:medical_valley/features/home/history/data/clinic_model.dart';
import 'package:medical_valley/features/home/history/presentation/bloc/clinics_bloc.dart';
import 'package:medical_valley/features/home/history/presentation/bloc/clinics_state.dart';
import 'package:medical_valley/features/home/history/widgets/filter_view.dart';
import 'package:rxdart/rxdart.dart';

import '../../../../core/app_sizes.dart';
import '../../../../core/strings/images.dart';
import '../../widgets/home_base_app_bar.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({Key? key}) : super(key: key);
  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  ClinicsBloc clinicsBloc = getIt.get<ClinicsBloc>();
  BehaviorSubject<bool> optionDisplayed = BehaviorSubject();
  BehaviorSubject<int> sortOption = BehaviorSubject();

  @override
  void initState() {
    optionDisplayed.sink.add(false);
    sortOption.sink.add(0);
    clinicsBloc.getAllClinics();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => optionDisplayed.sink.add(false),
      child: Scaffold(
        appBar: CustomHomeAppBar(
          searchHint: AppLocalizations.of(context)!.search,
          goodMorningText: AppLocalizations.of(context)!.good_morning,
          leadingIcon: Image.asset(
            appIcon,
            width: appBarIconWidth.w,
            height: appBarIconHeight.h,
          ),
          isTwoLineTitle: true,
          isSearchableAppBar: false,
        ),
        body: BlocBuilder<ClinicsBloc, ClinicsState>(
            bloc: clinicsBloc,
            builder: (context, state) {
              if (state.states == ActionStates.loading ||
                  state.states == ActionStates.idle) {
                return const Center(
                  child: CircularProgressIndicator(
                    color: primaryColor,
                  ),
                );
              } else if (state.states == ActionStates.success) {
                return Stack(
                  children: [
                    Column(
                      children: [
                        FilterView(onSortTapped: () {
                          optionDisplayed.sink.add(!optionDisplayed.value);
                        }),
                        Expanded(
                          child: ListView.builder(
                            shrinkWrap: true,
                            physics: const BouncingScrollPhysics(),
                            padding: const EdgeInsets.only(
                              bottom: 20,
                            ),
                            itemCount: state.clinics?.items?.length,
                            itemBuilder: (BuildContext context, int index) {
                              return ClinicCard(state.clinics!.items![index]);
                            },
                          ),
                        ),
                      ],
                    ),
                    Positioned(
                      top: 30.h,
                      right: 0,
                      child: StreamBuilder<bool>(
                          stream: optionDisplayed.stream,
                          builder: (context, snapshot) {
                            return optionDisplayed.value
                                ? Visibility(
                                    visible: optionDisplayed.value,
                                    child: Container(
                                      padding: smallPaddingAll,
                                      margin: smallPaddingH,
                                      height: 160.h,
                                      width: 250.w,
                                      decoration: BoxDecoration(
                                          border: Border.all(width: .2),
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(8)),
                                      child: StreamBuilder<int>(
                                          stream: sortOption.stream,
                                          builder: (context, snapshot) {
                                            return Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceAround,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children:
                                                  AppInitializer.sortChoicesHistory
                                                      .map((e) => Padding(
                                                            padding:
                                                                smallPaddingAll,
                                                            child:
                                                                GestureDetector(
                                                              onTap: () {
                                                                sortOption.sink.add(
                                                                    AppInitializer
                                                                        .sortChoicesHistory
                                                                        .indexOf(
                                                                            e));
                                                              },
                                                              child: Container(
                                                                child: Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .spaceBetween,
                                                                  children: [
                                                                    Text(AppInitializer
                                                                        .sortChoicesHistory[AppInitializer
                                                                            .sortChoicesHistory
                                                                            .indexOf(e)]
                                                                        .sortOption),
                                                                    sortOption.value ==
                                                                            AppInitializer.sortChoicesHistory.indexOf(
                                                                                e)
                                                                        ? const Icon(Icons
                                                                            .radio_button_checked)
                                                                        : const Icon(
                                                                            Icons.circle_outlined)
                                                                  ],
                                                                ),
                                                              ),
                                                            ),
                                                          ))
                                                      .toList(),
                                            );
                                          }),
                                    ),
                                  )
                                : SizedBox(
                                    height: 140.h,
                                  );
                          }),
                    ),
                  ],
                );
              } else {
                return const Center(
                  child: Text("There is a problem will be fixed soon"),
                );
              }
            }),
      ),
    );
  }
}

class ClinicCard extends StatelessWidget {
  final Items items;

  const ClinicCard(this.items, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
          color: whiteColor,
          borderRadius: BorderRadius.circular(16),
          boxShadow: const [
            BoxShadow(
                color: Color(0xffF2F2F2),
                offset: Offset(2, 2),
                blurRadius: 3,
                spreadRadius: 2)
          ]),
      child: Column(
        children: [
          Padding(
            padding:
                const EdgeInsets.only(left: 12, right: 12, top: 12, bottom: 12),
            child: Row(
              children: [
                Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.grey.shade300),
                      image: DecorationImage(
                        image: NetworkImage(items.image!),
                      )),
                ),
                const SizedBox(width: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      items.clinicName ?? "",
                      style: AppStyles.baloo2FontWith400WeightAnd18SizeAndBlack,
                    ),
                    const SizedBox(height: 2),
                    Row(
                      children: [
                        const Icon(
                          Icons.star,
                          color: Color(0xffEB8B17),
                          size: 16,
                        ),
                        Text(
                          " ${items.rate}",
                          style: AppStyles
                              .baloo2FontWith400WeightAnd18SizeAndBlack
                              .copyWith(color: const Color(0xffD8D7D9)),
                        ),
                      ],
                    ),
                    const SizedBox(height: 2),
                    Row(
                      children: [
                        Text(
                          items.distance.toString(),
                          style: AppStyles
                              .baloo2FontWith400WeightAnd18SizeAndBlack,
                        ),
                        Text(
                          " ${items.distanceUnit}",
                          style: AppStyles
                              .baloo2FontWith400WeightAnd18SizeAndBlack,
                        ),
                      ],
                    ),
                  ],
                ),
                const Spacer(),
                Column(
                  children: [
                    Text(
                      "${items.timeAgo.toString()} ${items.timeUnit.toString()}",
                      style: AppStyles.baloo2FontWith400WeightAnd18SizeAndBlack,
                    ),
                    const SizedBox(height: 8),
                    Container(
                      decoration: BoxDecoration(
                          color: primaryColor,
                          borderRadius: BorderRadius.circular(8)),
                      alignment: Alignment.center,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 10),
                      child: Text(
                        "${items.price} RS",
                        style: AppStyles
                            .baloo2FontWith400WeightAnd18SizeAndBlack
                            .copyWith(color: whiteColor, fontSize: 14),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
          Padding(
            padding: smallPaddingHV,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  children: const [
                    Icon(
                      Icons.circle,
                      color: Colors.grey,
                      size: 10,
                    ),
                    DottedLine(
                      direction: Axis.vertical,
                      lineLength: 30,
                      lineThickness: 1.0,
                      dashLength: 4.0,
                      dashColor: primaryColor,
                      dashRadius: 0.0,
                      dashGapLength: 4.0,
                      dashGapColor: Colors.transparent,
                      dashGapRadius: 0.0,
                    ),
                    const Icon(
                      Icons.circle,
                      color: primaryColor,
                      size: 10,
                    ),
                  ],
                ),
                const SizedBox(
                  width: 8,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "some place",
                      style:
                          AppStyles.baloo2FontWith400WeightAnd18Size.copyWith(
                        color: Colors.grey,
                        decoration: TextDecoration.none,
                      ),
                    ),
                    const SizedBox(
                      height: 17,
                    ),
                    Text(
                      "some place",
                      style: AppStyles.baloo2FontWith500WeightAnd15Size
                          .copyWith(color: primaryColor),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 8),
            color: const Color(0xffF9F9F9),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const Icon(
                  Icons.location_pin,
                  color: primaryColor,
                ),
                Text(
                  "${items.address}",
                  style: AppStyles.baloo2FontWith400WeightAnd18SizeAndBlack,
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 12, right: 12, bottom: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: const [
                ButtonWidget(secondaryColor, "Negotiate again"),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class ButtonWidget extends StatelessWidget {
  final Color color;
  final String title;
  const ButtonWidget(this.color, this.title, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration:
            BoxDecoration(color: color, borderRadius: BorderRadius.circular(8)),
        child: Text(
          title,
          style: AppStyles.baloo2FontWith400WeightAnd20SizeAndBlack
              .copyWith(color: whiteColor),
        ),
      ),
    );
  }
}
