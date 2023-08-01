import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:medical_valley/core/app_colors.dart';
import 'package:medical_valley/core/dialogs/loading_dialog.dart';
import 'package:medical_valley/core/medical_injection.dart';
import 'package:medical_valley/features/home/history/data/negotiations/negotiations_model.dart';
import 'package:medical_valley/features/home/history/presentation/bloc/history_bloc.dart';
import 'package:medical_valley/features/home/history/presentation/bloc/history_state.dart';
import 'package:medical_valley/features/home/history/presentation/widgets/negotiation_card.dart';
import 'package:medical_valley/features/offers/presentation/offers_screen.dart';
import 'package:medical_valley/features/offers/presentation/presentation/bloc/negotiate/negotiate_bloc.dart';
import 'package:medical_valley/features/offers/presentation/presentation/bloc/negotiate/negotiate_state.dart';
import 'package:rxdart/rxdart.dart';

class NegotiationsScreen extends StatefulWidget {
  final VoidCallback onBookedConfirmed;
  const NegotiationsScreen({required this.onBookedConfirmed, Key? key})
      : super(key: key);

  @override
  State<NegotiationsScreen> createState() => _ReservationScreenState();
}

class _ReservationScreenState extends State<NegotiationsScreen> {
  final PagingController<int, NegotiationModel> pagingController =
      PagingController(
    firstPageKey: 1,
  );
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
    return Stack(
      children: [
        BlocListener<NegotiateBloc, NegotiateState>(
            bloc: negotiateBloc,
            listenWhen: (prev, current) =>
                current is VerifyRequestStateLoading ||
                current is VerifyRequestStateSuccess ||
                current is VerifyRequestStateError,
            listener: (context, state) {
              if (state is VerifyRequestStateLoading) {
                LoadingDialogs.showLoadingDialog(context);
              } else if (state is VerifyRequestStateSuccess) {
                LoadingDialogs.hideLoadingDialog();
                CoolAlert.show(
                  barrierDismissible: false,
                  context: context,
                  autoCloseDuration: const Duration(seconds: 1),
                  showOkBtn: false,
                  type: CoolAlertType.success,
                  title: AppLocalizations.of(context)!.success,
                  text: AppLocalizations.of(context)!.booked_done,
                );
                Future.delayed(const Duration(seconds: 2), () async {
                  widget.onBookedConfirmed();
                });
              } else {
                LoadingDialogs.hideLoadingDialog();
                CoolAlert.show(
                  barrierDismissible: false,
                  context: context,
                  autoCloseDuration: const Duration(seconds: 1),
                  showOkBtn: false,
                  closeOnConfirmBtnTap: true,
                  type: CoolAlertType.error,
                  text: AppLocalizations.of(context)!.something_went_wrong,
                );
              }
            },
            child: const SizedBox()),
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
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  builderDelegate: PagedChildBuilderDelegate(
                    noItemsFoundIndicatorBuilder: (BuildContext context) {
                      return Center(
                        child: Text(
                            AppLocalizations.of(context)!.there_is_no_offers),
                      );
                    },
                    itemBuilder: (context, NegotiationModel item, index) {
                      return NegotiationsCard(
                        items: item,
                        onNegotiatePressed: onNegotiatePressed,
                        onBookPressed: (int? id) {
                          negotiateBloc.verifyRequest(id ?? 0);
                        },
                      );
                    },
                  ),
                );
              } else {
                return Center(
                  child:
                      Text(AppLocalizations.of(context)!.something_went_wrong),
                );
              }
            }),
      ],
    );
  }

  onNegotiatePressed(int id) {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (c) => OffersScreen(requestId: id)));
  }
}
