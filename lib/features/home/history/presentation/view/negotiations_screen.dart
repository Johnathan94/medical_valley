import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:medical_valley/core/app_colors.dart';
import 'package:medical_valley/core/medical_injection.dart';
import 'package:medical_valley/features/home/history/data/negotiations/negotiations_model.dart';
import 'package:medical_valley/features/home/history/presentation/bloc/history_bloc.dart';
import 'package:medical_valley/features/home/history/presentation/bloc/history_state.dart';
import 'package:medical_valley/features/home/history/presentation/widgets/negotiation_card.dart';
import 'package:medical_valley/features/offers/presentation/data/model/verifyModel/verify_model.dart';
import 'package:medical_valley/features/offers/presentation/presentation/bloc/negotiate/negotiate_bloc.dart';
import 'package:rxdart/rxdart.dart';

class NegotiationsScreen extends StatefulWidget {
  const NegotiationsScreen({Key? key}) : super(key: key);

  @override
  State<NegotiationsScreen> createState() => _ReservationScreenState();
}

class _ReservationScreenState extends State<NegotiationsScreen> {
  final PagingController<int, NegotiationModel> pagingController =
      PagingController(firstPageKey: 1);
  HistoryBloc historyBloc = getIt.get<HistoryBloc>();
  BehaviorSubject<int> rxNegotiateCount = BehaviorSubject();
  NegotiateBloc negotiateBloc = getIt.get<NegotiateBloc>();

  int nextPageKey = 1;
  int nextPage = 1;
  @override
  void initState() {
    historyBloc.getNegotiations(1, 10);
    pagingController.addPageRequestListener((pageKey) {
      nextPageKey = pageKey;
      nextPage += 1;
      historyBloc.getNegotiations(nextPage, 10);
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
          } else if (state.states == ActionStates.success) {
            if (state.negotiations?.data?.results!.length == 10) {
              pagingController.appendPage(
                  state.negotiations!.data!.results!, nextPageKey);
            } else {
              if (pagingController.value.itemList !=
                  state.negotiations?.data?.results!) {
                pagingController
                    .appendLastPage(state.negotiations!.data!.results!);
              }
            }

            return PagedListView<int, NegotiationModel>(
              pagingController: pagingController,
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              builderDelegate: PagedChildBuilderDelegate(
                itemBuilder: (context, NegotiationModel item, index) {
                  return NegotiationsCard(
                    items: item,
                    onNegotiatePressed: onNegotiatePressed,
                    onBookPressed: (int? id) {
                      negotiateBloc.verifyRequest(VerifyRequest(requestId: id));
                    },
                  );
                },
              ),
            );
          } else {
            return Center(
              child: Text(AppLocalizations.of(context)!.something_went_wrong),
            );
          }
        });
  }

  onNegotiatePressed(int id) {
    negotiateBloc.negotiate([id]);
  }
}
