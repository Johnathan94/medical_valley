import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:medical_valley/core/app_colors.dart';
import 'package:medical_valley/core/medical_injection.dart';
import 'package:medical_valley/features/home/history/data/reservations/reservations_model.dart';
import 'package:medical_valley/features/home/history/presentation/bloc/history_bloc.dart';
import 'package:medical_valley/features/home/history/presentation/bloc/history_state.dart';
import 'package:medical_valley/features/home/history/presentation/widgets/reservation_card.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class ReservationsScreen extends StatefulWidget {
  const ReservationsScreen({Key? key}) : super(key: key);

  @override
  State<ReservationsScreen> createState() => _ReservationScreenState();
}

class _ReservationScreenState extends State<ReservationsScreen> {
  final PagingController<int, ReservationModel> pagingController =
      PagingController(firstPageKey: 1);
  HistoryBloc historyBloc = getIt.get<HistoryBloc>();

  int nextPageKey = 1;
  int nextPage = 1;
  @override
  void initState() {
    historyBloc.getReservations(1, 10);
    pagingController.addPageRequestListener((pageKey) {
      nextPageKey = pageKey;
      nextPage += 1;
      historyBloc.getReservations(nextPage, 10);
    });

    super.initState();
  }

  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  void _onRefreshReservations() async {
    await Future.delayed(const Duration(milliseconds: 1000));
    pagingController.value.itemList?.clear();
    nextPage = 1;
    nextPageKey = 1;
    historyBloc.getReservations(1, 10);
    _refreshController.refreshCompleted();
  }

  void _onLoading() async {
    await Future.delayed(const Duration(milliseconds: 1000));
    _refreshController.loadComplete();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HistoryBloc, HistoryState>(
        bloc: historyBloc,
        listener: (context, state) {
          if (state.states == ActionStates.success) {
            if (state.reservations?.data?.results!.length == 10) {
              pagingController.appendPage(
                  state.reservations!.data!.results!, nextPageKey);
            } else {
              if (pagingController.value.itemList !=
                  state.reservations?.data?.results!) {
                pagingController
                    .appendLastPage(state.reservations!.data!.results!);
              }
            }
          }
        },
        builder: (context, state) {
          if (state.states == ActionStates.loading ||
              state.states == ActionStates.idle) {
            return const Center(
              child: CircularProgressIndicator(
                color: primaryColor,
              ),
            );
          } else if (state.states == ActionStates.success) {
            return Padding(
              padding: const EdgeInsets.all(10.0),
              child: SmartRefresher(
                enablePullDown: true,
                enablePullUp: true,
                header: const WaterDropHeader(),
                controller: _refreshController,
                onRefresh: _onRefreshReservations,
                onLoading: _onLoading,
                child: PagedListView<int, ReservationModel>(
                  pagingController: pagingController,
                  builderDelegate: PagedChildBuilderDelegate(
                    itemBuilder: (context, ReservationModel item, index) {
                      return ReservationsCard(item);
                    },
                    noItemsFoundIndicatorBuilder: (BuildContext context) {
                      return Center(
                        child: Text(AppLocalizations.of(context)!
                            .there_is_no_reservations),
                      );
                    },
                  ),
                ),
              ),
            );
          } else {
            return Center(
              child: Text(AppLocalizations.of(context)!.something_went_wrong),
            );
          }
        });
  }
}
