import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:medical_valley/core/app_colors.dart';
import 'package:medical_valley/core/app_initialized.dart';
import 'package:medical_valley/core/app_paddings.dart';
import 'package:medical_valley/core/medical_injection.dart';
import 'package:medical_valley/features/home/history/data/requests/requests_model.dart';
import 'package:medical_valley/features/home/history/presentation/bloc/history_bloc.dart';
import 'package:medical_valley/features/home/history/presentation/bloc/history_state.dart';
import 'package:medical_valley/features/home/history/presentation/history_screen.dart';
import 'package:medical_valley/features/home/history/widgets/filter_view.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:rxdart/rxdart.dart';

class RequestsScreen extends StatefulWidget {
  final BehaviorSubject<bool> optionDisplayed;
  final BehaviorSubject<int> sortOption;
  const RequestsScreen(this.sortOption, this.optionDisplayed, {Key? key})
      : super(key: key);

  @override
  State<RequestsScreen> createState() => _RequestsScreenState();
}

class _RequestsScreenState extends State<RequestsScreen> {
  HistoryBloc historyBloc = getIt.get<HistoryBloc>();

  final PagingController<int, HistoryItem> pagingController =
      PagingController(firstPageKey: 1);

  int nextPage = 1;
  int nextPageKey = 1;
  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  void _onLoading() async {
    await Future.delayed(const Duration(milliseconds: 1000));
    _refreshController.loadComplete();
  }

  void _onRefreshRequests() async {
    await Future.delayed(const Duration(milliseconds: 1000));
    pagingController.value.itemList?.clear();
    nextPage = 1;
    nextPageKey = 1;
    historyBloc.getUserRequests(1, 10);
    _refreshController.refreshCompleted();
  }

  @override
  void initState() {
    historyBloc.getUserRequests(1, 10);
    pagingController.addPageRequestListener((pageKey) {
      nextPageKey = pageKey;
      nextPage += 1;
      historyBloc.getUserRequests(nextPage, 10);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HistoryBloc, HistoryState>(
        bloc: historyBloc,
        builder: (context, state) {
          if (state.states == ActionStates.loading ||
              state.states == ActionStates.idle) {
            return const Center(
              child: CircularProgressIndicator(
                color: primaryColor,
              ),
            );
          } else if (state.states == ActionStates.success ||
              state.states == ActionStates.filter) {
            if (state.states == ActionStates.filter) {
              pagingController.refresh();
            }
            if (state.requests?.data?.results!.length == 10) {
              pagingController.appendPage(
                  state.requests!.data!.results!, nextPageKey);
            } else {
              if (pagingController.value.itemList !=
                  state.requests?.data?.results!) {
                pagingController.appendLastPage(state.requests!.data!.results!);
              }
            }

            return Stack(
              children: [
                Column(
                  children: [
                    state.requests!.data!.results!.isNotEmpty
                        ? FilterView(
                            totalRequestsNumber:
                                state.requests?.data?.totalCount ?? 0,
                            onSortTapped: () {
                              widget.optionDisplayed.sink
                                  .add(!widget.optionDisplayed.value);
                            })
                        : const SizedBox(),
                    Expanded(
                        child: SmartRefresher(
                      enablePullDown: true,
                      enablePullUp: true,
                      header: const WaterDropHeader(),
                      controller: _refreshController,
                      onRefresh: _onRefreshRequests,
                      onLoading: _onLoading,
                      child: PagedListView<int, HistoryItem>(
                        pagingController: pagingController,
                        builderDelegate: PagedChildBuilderDelegate(
                          itemBuilder: (context, HistoryItem item, index) {
                            return HistoryCard(item);
                          },
                          noItemsFoundIndicatorBuilder: (BuildContext context) {
                            return Center(
                              child: Text(AppLocalizations.of(context)!
                                  .there_is_no_requests),
                            );
                          },
                        ),
                      ),
                    )),
                  ],
                ),
                Positioned(
                  top: 30.h,
                  right: 0,
                  child: StreamBuilder<bool>(
                      stream: widget.optionDisplayed.stream,
                      builder: (context, snapshot) {
                        return widget.optionDisplayed.value
                            ? Visibility(
                                visible: widget.optionDisplayed.value,
                                child: Container(
                                  padding: smallPaddingAll,
                                  margin: smallPaddingH,
                                  height: 120.h,
                                  width: 270.w,
                                  decoration: BoxDecoration(
                                      border: Border.all(width: .2),
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(8)),
                                  child: StreamBuilder<int>(
                                      stream: widget.sortOption.stream,
                                      builder: (context, snapshot) {
                                        return Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: AppInitializer
                                              .sortChoicesHistory
                                              .map((e) => Padding(
                                                    padding: smallPaddingAll,
                                                    child: GestureDetector(
                                                      onTap: () {
                                                        widget.sortOption.sink
                                                            .add(AppInitializer
                                                                .sortChoicesHistory
                                                                .indexOf(e));
                                                        historyBloc.filter(
                                                            widget.sortOption
                                                                .value);
                                                        widget.optionDisplayed
                                                            .sink
                                                            .add(false);
                                                      },
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Text(AppInitializer
                                                              .sortChoicesHistory[
                                                                  AppInitializer
                                                                      .sortChoicesHistory
                                                                      .indexOf(
                                                                          e)]
                                                              .sortOption),
                                                          widget.sortOption
                                                                      .value ==
                                                                  AppInitializer
                                                                      .sortChoicesHistory
                                                                      .indexOf(
                                                                          e)
                                                              ? const Icon(Icons
                                                                  .radio_button_checked)
                                                              : const Icon(Icons
                                                                  .circle_outlined)
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
              child: Text(AppLocalizations.of(context)!.something_went_wrong),
            );
          }
        });
  }
}
