import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:intl/intl.dart';
import 'package:medical_valley/core/app_colors.dart';
import 'package:medical_valley/core/app_initialized.dart';
import 'package:medical_valley/core/app_paddings.dart';
import 'package:medical_valley/core/app_styles.dart';
import 'package:medical_valley/core/extensions/string_extensions.dart';
import 'package:medical_valley/core/medical_injection.dart';
import 'package:medical_valley/core/shared_pref/shared_pref.dart';
import 'package:medical_valley/features/auth/phone_verification/data/model/otp_response_model.dart';
import 'package:medical_valley/features/home/history/data/requests/requests_model.dart';
import 'package:medical_valley/features/home/history/presentation/bloc/history_bloc.dart';
import 'package:medical_valley/features/home/history/presentation/bloc/history_state.dart';
import 'package:medical_valley/features/home/history/presentation/view/negotiations_screen.dart';
import 'package:medical_valley/features/home/history/presentation/view/reservation_screen.dart';
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

class _HistoryScreenState extends State<HistoryScreen>
    with SingleTickerProviderStateMixin {
  HistoryBloc historyBloc = getIt.get<HistoryBloc>();
  BehaviorSubject<bool> optionDisplayed = BehaviorSubject();
  BehaviorSubject<int> sortOption = BehaviorSubject();
  late UserDate currentUser;
  final PagingController<int, HistoryItem> pagingController =
      PagingController(firstPageKey: 1);
  late final TabController tabController;
  int nextPage = 1;
  int nextPageKey = 1;
  @override
  void initState() {
    tabController = TabController(length: 3, vsync: this);
    optionDisplayed.sink.add(false);
    sortOption.sink.add(0);
    historyBloc.getUserRequests(1, 10);
    pagingController.addPageRequestListener((pageKey) {
      nextPageKey = pageKey;
      nextPage += 1;
      historyBloc.getUserRequests(nextPage, 10);
    });
    currentUser = UserDate.fromJson(LocalStorageManager.getUser()!);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => optionDisplayed.sink.add(false),
      child: Scaffold(
        appBar: CustomHomeAppBar(
          hasSearchIcon: false,
          controller: TextEditingController(),
          searchHint: AppLocalizations.of(context)!.search,
          goodMorningText: AppLocalizations.of(context)!.good_morning,
          leadingIcon: Image.asset(
            appIcon,
            width: appBarIconWidth.w,
            height: appBarIconHeight.h,
          ),
          bottom: TabBar(
            controller: tabController,
            indicatorColor: Colors.white, //<-- SEE HERE
            tabs: [
              Tab(
                text: AppLocalizations.of(context)!.requests,
              ),
              Tab(
                text: AppLocalizations.of(context)!.negotiations,
              ),
              Tab(
                text: AppLocalizations.of(context)!.reservations,
              ),
            ],
          ),
          isTwoLineTitle: true,
          isSearchableAppBar: false,
          username: currentUser.fullName ?? "",
          context: context,
          onBackPressed: () {},
        ),
        body: TabBarView(controller: tabController, children: [
          BlocBuilder<HistoryBloc, HistoryState>(
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
                  if (state.requests?.data?.results!.length == 10) {
                    pagingController.appendPage(
                        state.requests!.data!.results!, nextPageKey);
                  } else {
                    if (pagingController.value.itemList !=
                        state.requests?.data?.results!) {
                      pagingController
                          .appendLastPage(state.requests!.data!.results!);
                    }
                  }

                  return Stack(
                    children: [
                      Column(
                        children: [
                          FilterView(
                              totalRequestsNumber:
                                  state.requests?.data?.totalCount ?? 0,
                              onSortTapped: () {
                                optionDisplayed.sink
                                    .add(!optionDisplayed.value);
                              }),
                          Expanded(
                              child: PagedListView<int, HistoryItem>(
                            pagingController: pagingController,
                            builderDelegate: PagedChildBuilderDelegate(
                              itemBuilder: (context, HistoryItem item, index) {
                                return HistoryCard(item);
                              },
                            ),
                          )),
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
                                                    MainAxisAlignment
                                                        .spaceAround,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children:
                                                    AppInitializer
                                                        .sortChoicesHistory
                                                        .map((e) => Padding(
                                                              padding:
                                                                  smallPaddingAll,
                                                              child:
                                                                  GestureDetector(
                                                                onTap: () {
                                                                  sortOption
                                                                      .sink
                                                                      .add(AppInitializer
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
                } else {
                  return Center(
                    child: Text(
                        AppLocalizations.of(context)!.something_went_wrong),
                  );
                }
              }),
          NegotiationsScreen(onBookedConfirmed: () {
            tabController.animateTo(2);
          }),
          const ReservationsScreen(),
        ]),
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
                color: Color(0xffE7E7E7),
                offset: Offset(4, 4),
                blurRadius: 5,
                spreadRadius: 5)
          ]),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding:
                const EdgeInsets.only(left: 8, right: 8, top: 12, bottom: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 9,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        flex: 1,
                        child: Column(
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
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      Expanded(
                        flex: 10,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              item?.categoryStr ?? "",
                              style: AppStyles.baloo2FontWith400WeightAnd18Size
                                  .copyWith(
                                color: textGrey,
                                decoration: TextDecoration.none,
                              ),
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    item?.providerServiceName ?? "",
                                    style: AppStyles
                                        .baloo2FontWith400WeightAnd14Size
                                        .copyWith(color: primaryColor),
                                    maxLines: 1,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        item!.appointmentDate != null
                            ? DateFormat("dd/MM/yyyy")
                                .format(DateTime.parse(item!.appointmentDate!))
                            : "No Date",
                        style:
                            AppStyles.baloo2FontWith400WeightAnd18SizeAndBlack,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          AppointmentTypeView(
              id: item?.bookingTypeId ?? 0, text: item?.bookingTypeStr ?? ""),
          const SizedBox(
            height: 15,
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
  final String text;
  final int id;
  const AppointmentTypeView({required this.id, required this.text, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return id.toStatusView(text);
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
