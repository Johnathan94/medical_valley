import 'dart:convert';

import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:medical_valley/core/app_colors.dart';
import 'package:medical_valley/core/app_initialized.dart';
import 'package:medical_valley/core/app_paddings.dart';
import 'package:medical_valley/core/app_styles.dart';
import 'package:medical_valley/core/medical_injection.dart';
import 'package:medical_valley/core/shared_pref/shared_pref.dart';
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
  HistoryBloc historyBloc = getIt.get<HistoryBloc>();
  BehaviorSubject<bool> optionDisplayed = BehaviorSubject();
  BehaviorSubject<int> sortOption = BehaviorSubject();
  Map<String , dynamic > currentUser = {} ;
  final PagingController<int, HistoryItem> pagingController =
  PagingController(firstPageKey: 1);
  int nextPage = 1 ;
  int nextPageKey = 1 ;
  @override
  void initState() {
    optionDisplayed.sink.add(false);
    sortOption.sink.add(0);
    historyBloc.getAllHistoryNegotiations(1, 10);
    pagingController.addPageRequestListener((pageKey) {
      nextPageKey = pageKey;
      nextPage += 1;
      historyBloc.getAllHistoryNegotiations(nextPage, 10);

    });
    currentUser = LocalStorageManager.getUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => optionDisplayed.sink.add(false),
      child: Scaffold(
        appBar: CustomHomeAppBar(
          controller: TextEditingController(),
          searchHint: AppLocalizations.of(context)!.search,
          goodMorningText: AppLocalizations.of(context)!.good_morning,
          leadingIcon: Image.asset(
            appIcon,
            width: appBarIconWidth.w,
            height: appBarIconHeight.h,
          ),
          isTwoLineTitle: true,
          isSearchableAppBar: false, username: currentUser["data"]["data"]["fullName"], context: context,
          onBackPressed: (){},
        ),
        body: BlocBuilder<HistoryBloc, HistoryState>(
            bloc: historyBloc,
            builder: (context, state) {
              if (state.states == ActionStates.loading ||
                  state.states == ActionStates.idle) {
                return const Center(
                  child: CircularProgressIndicator(
                    color: primaryColor,
                  ),
                );
              } else if (state.states == ActionStates.success) {
                  if(state.history?.data?.results!.length == 10){
                    pagingController.appendPage(state.history!.data!.results!, nextPageKey);
                  }else {
                    if(pagingController.value.itemList != state.history?.data?.results!) {
                      pagingController.appendLastPage(
                          state.history!.data!.results!);
                    }
                  }

                return Stack(
                  children: [
                    Column(
                      children: [
                        FilterView(onSortTapped: () {
                          optionDisplayed.sink.add(!optionDisplayed.value);
                        }),
                        Expanded(
                          child: PagedListView<int, HistoryItem>(
                            pagingController: pagingController,
                            builderDelegate: PagedChildBuilderDelegate(
                              itemBuilder: (context, HistoryItem item, index) {
                                return HistoryCard(item);
                              },
                            ),
                          )
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
                                      height: 180.h,
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
              }
              else {
                return Center(
                  child: Text(AppLocalizations.of(context)!.something_went_wrong),
                ) ;
              }
            }),
      ),
    );
  }
}

class HistoryCard extends StatelessWidget {
  final HistoryItem? item;

  const HistoryCard(this.item, {Key? key}) : super(key: key);

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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding:
                const EdgeInsets.only(left: 12, right: 12, top: 12, bottom: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
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
                          Icon(
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
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            item?.categoryStr ?? "",
                            style:
                            AppStyles.baloo2FontWith400WeightAnd18Size.copyWith(
                              color: textGrey,
                              decoration: TextDecoration.none,
                            ),
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          Text(
                            item?.serviceStr ?? "",
                            style: AppStyles.baloo2FontWith400WeightAnd14Size
                                .copyWith(color: primaryColor),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Text(
                  item?.mobileStr ?? "",
                  style: AppStyles
                      .baloo2FontWith400WeightAnd18SizeAndBlack,
                ),
              ],
            ),
          ),
          const AppointmentTypeView(),
          const SizedBox(height: 15,),
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
                  item?.userStr ?? "",
                  style: AppStyles.baloo2FontWith400WeightAnd18SizeAndBlack,
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 8,
          ),

        ],
      ),
    );
  }
}

class AppointmentTypeView extends StatelessWidget {
  const AppointmentTypeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin:const EdgeInsets.symmetric(horizontal: 22),
      padding:const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration:  BoxDecoration(
        color: const Color(0xffCBE6EC),
        borderRadius: BorderRadius.circular(7)
      ),
      child:  Text("Immediate Date" , style: AppStyles.baloo2FontWith400WeightAnd14Size.copyWith(
        color: primaryColor
      ),
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
