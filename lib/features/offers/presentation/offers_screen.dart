import 'package:cool_alert/cool_alert.dart';
import 'package:expansion_tile_group/expansion_tile_group.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:medical_valley/core/app_colors.dart';
import 'package:medical_valley/core/app_styles.dart';
import 'package:medical_valley/core/dialogs/loading_dialog.dart';
import 'package:medical_valley/core/medical_injection.dart';
import 'package:medical_valley/core/shared_pref/shared_pref.dart';
import 'package:medical_valley/core/strings/images.dart';
import 'package:medical_valley/core/widgets/custom_app_bar.dart';
import 'package:medical_valley/features/home/history/data/negotiations/negotiations_model.dart';
import 'package:medical_valley/features/offers/presentation/presentation/bloc/negotiate/negotiate_bloc.dart';
import 'package:medical_valley/features/offers/presentation/presentation/bloc/negotiate/negotiate_state.dart';
import 'package:medical_valley/features/offers/presentation/presentation/bloc/offers_bloc.dart';
import 'package:medical_valley/features/offers/presentation/presentation/bloc/offers_state.dart';
import 'package:medical_valley/features/offers/presentation/presentation/offer_ui_response.dart';
import 'package:medical_valley/features/offers/widgets/offers_options_button.dart';
import 'package:medical_valley/features/payment/persentation/screens/payment_screen.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:rxdart/rxdart.dart';

class OffersScreen extends StatefulWidget {
  final int requestId;

  const OffersScreen({required this.requestId, Key? key}) : super(key: key);

  @override
  State<OffersScreen> createState() => _OffersScreenState();
}

class _OffersScreenState extends State<OffersScreen> {
  BehaviorSubject<bool> optionDisplayed = BehaviorSubject();
  OffersBloc offersBloc = getIt.get<OffersBloc>();
  NegotiateBloc negotiateBloc = getIt.get<NegotiateBloc>();
  BehaviorSubject<int> sortOption = BehaviorSubject();
  BehaviorSubject<List<int>?> negotiatedOffersSubject = BehaviorSubject();
  final PagingController<int, OfferUiResponseModel> pagingController =
      PagingController(firstPageKey: 1);
  int nextPage = 1;
  int nextPageKey = 1;

  @override
  void initState() {
    offersBloc.getOffers(OffersEvent(nextPage, 10, widget.requestId));
    negotiatedOffersSubject.sink.add([]);
    pagingController.addPageRequestListener((pageKey) {
      nextPageKey = pageKey;
      nextPage += 1;
      offersBloc.getOffers(OffersEvent(nextPage, 10, widget.requestId));
    });
    optionDisplayed.sink.add(false);
    sortOption.sink.add(0);
    super.initState();
  }

  void _onRefresh() async {
    pagingController.value.itemList?.clear();
    await Future.delayed(const Duration(milliseconds: 1000));
    offersBloc.getOffers(OffersEvent(nextPage, 10, widget.requestId));
    _refreshController.refreshCompleted();
  }

  void _onLoading() async {
    await Future.delayed(const Duration(milliseconds: 1000));
    _refreshController.loadComplete();
  }

  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: GestureDetector(
        onTap: () => optionDisplayed.sink.add(false),
        child: Scaffold(
          appBar: MyCustomAppBar(
            header: AppLocalizations.of(context)!.request_price,
            leadingIcon: GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                  LocalStorageManager.resetNegotiationCount();
                },
                child: const Icon(Icons.arrow_back_ios)),
          ),
          body: Stack(
            children: [
              BlocBuilder<OffersBloc, OffersState>(
                  bloc: offersBloc,
                  builder: (context, state) {
                    if (state is OffersStateLoading) {
                      return SizedBox(
                          height: MediaQuery.of(context).size.height,
                          width: MediaQuery.of(context).size.width,
                          child:
                              const Center(child: CircularProgressIndicator()));
                    }
                    if (state is OffersStateSuccess) {
                      if (state.offersResponse.length == 10) {
                        pagingController.appendPage(
                            state.offersResponse, nextPageKey);
                      } else {
                        if (pagingController.value.itemList != null &&
                            state.offersResponse.isNotEmpty) {
                          if (!pagingController.value.itemList!
                              .contains(state.offersResponse.first)) {
                            pagingController
                                .appendLastPage(state.offersResponse);
                          }
                        } else {
                          pagingController.appendLastPage(state.offersResponse);
                        }
                      }
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 60.0),
                        child: StreamBuilder<List<int>?>(
                            stream: negotiatedOffersSubject.stream,
                            builder: (context, snapshot) {
                              return SmartRefresher(
                                enablePullDown: true,
                                enablePullUp: true,
                                header: const WaterDropHeader(),
                                controller: _refreshController,
                                onRefresh: _onRefresh,
                                onLoading: _onLoading,
                                child: PagedListView<int, OfferUiResponseModel>(
                                  pagingController: pagingController,
                                  builderDelegate: PagedChildBuilderDelegate(
                                    noItemsFoundIndicatorBuilder:
                                        (BuildContext context) {
                                      return Center(
                                        child: Text(
                                            AppLocalizations.of(context)!
                                                .there_is_no_offers),
                                      );
                                    },
                                    itemBuilder: (context,
                                        OfferUiResponseModel item, index) {
                                      return item.offers.isEmpty
                                          ? OfferCard(
                                              items: item.latestOffer,
                                              onNegotiatePressed:
                                                  onNegotiatePressed,
                                              onBookPressed: (int? id) {
                                                negotiateBloc
                                                    .verifyRequest(id ?? 0);
                                              },
                                              isEnabled: !offersNegotiatedIds!
                                                  .contains(
                                                      item.latestOffer.id),
                                              isNegotiable: true,
                                            )
                                          : ExpansionTileItem(
                                              isHasTrailing: false,
                                              clipBehavior: Clip.none,
                                              title: OfferCard(
                                                items: item.latestOffer,
                                                onNegotiatePressed:
                                                    onNegotiatePressed,
                                                onBookPressed: (int? id) {
                                                  negotiateBloc
                                                      .verifyRequest(id ?? 0);
                                                },
                                                isEnabled: !offersNegotiatedIds!
                                                    .contains(
                                                        item.latestOffer.id),
                                                isNegotiable: true,
                                                isExpanded: item.isExpanded,
                                              ),
                                              onExpansionChanged:
                                                  (bool expandedValue) {
                                                item.isExpanded =
                                                    !expandedValue;
                                                setState(() {});
                                              },
                                              initiallyExpanded:
                                                  item.isExpanded,
                                              children: <Widget>[
                                                ListView.builder(
                                                    shrinkWrap: true,
                                                    physics:
                                                        const NeverScrollableScrollPhysics(),
                                                    itemCount:
                                                        item.offers.length,
                                                    itemBuilder: (c, index) =>
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .symmetric(
                                                                  horizontal:
                                                                      16.0),
                                                          child: OfferCard(
                                                            items: item
                                                                .offers[index],
                                                            onNegotiatePressed:
                                                                onNegotiatePressed,
                                                            onBookPressed:
                                                                (int? id) {
                                                              negotiateBloc
                                                                  .verifyRequest(
                                                                      id ?? 0);
                                                            },
                                                            isEnabled: false,
                                                            isNegotiable: false,
                                                          ),
                                                        )),
                                              ],
                                            );
                                    },
                                  ),
                                ),
                              );
                            }),
                      );
                    } else {
                      return Center(
                          child: Text((state as OffersStateError).err));
                    }
                  }),
              StreamBuilder<List<int>?>(
                  stream: negotiatedOffersSubject.stream,
                  builder: (context, snapshot) {
                    return negotiatedOffersSubject.hasValue &&
                            negotiatedOffersSubject.value != null
                        ? Align(
                            alignment: Alignment.bottomCenter,
                            child: BlocListener<NegotiateBloc, NegotiateState>(
                                bloc: negotiateBloc,
                                listenWhen: (prev, current) =>
                                    current is NegotiateStateLoading ||
                                    current is NegotiateStateSuccess ||
                                    current is NegotiateStateError,
                                listener: (context, state) {
                                  if (state is NegotiateStateLoading) {
                                    LoadingDialogs.showLoadingDialog(context);
                                  } else if (state is NegotiateStateSuccess) {
                                    LoadingDialogs.hideLoadingDialog();
                                    CoolAlert.show(
                                      barrierDismissible: false,
                                      context: context,
                                      autoCloseDuration:
                                          const Duration(seconds: 1),
                                      showOkBtn: false,
                                      type: CoolAlertType.success,
                                      text: AppLocalizations.of(context)!
                                          .negotiate_successed,
                                      title:
                                          AppLocalizations.of(context)!.success,
                                    );
                                    Future.delayed(const Duration(seconds: 2),
                                        () async {
                                      Navigator.pop(context);
                                      pagingController.refresh();
                                      nextPage = 1;
                                      nextPageKey = 1;
                                      offersBloc.getOffers(OffersEvent(
                                          nextPage, 10, widget.requestId));
                                    });
                                  } else if (state is NegotiateStateError) {
                                    String? error;
                                    if (state.error.contains(
                                        "Can't negotiate on a request more than 3 times")) {
                                      error = AppLocalizations.of(context)!
                                          .cant_negotiate;
                                    }
                                    LoadingDialogs.hideLoadingDialog();
                                    CoolAlert.show(
                                        barrierDismissible: false,
                                        context: context,
                                        type: CoolAlertType.error,
                                        text: error ?? state.error,
                                        title:
                                            AppLocalizations.of(context)!.error,
                                        autoCloseDuration:
                                            const Duration(seconds: 3),
                                        showOkBtn: false,
                                        onConfirmBtnTap: () {
                                          Navigator.pop(context);
                                        });
                                  }
                                },
                                child: GestureDetector(
                                  onTap: () {
                                    if (negotiatedOffersSubject.hasValue &&
                                        negotiatedOffersSubject
                                            .value!.isNotEmpty) {
                                      negotiateBloc
                                          .negotiate(offersNegotiatedIds);
                                    }
                                  },
                                  child: Container(
                                    height: 90.h,
                                    alignment: Alignment.center,
                                    decoration: const BoxDecoration(
                                        color: secondaryColor),
                                    child: Text(
                                      "${AppLocalizations.of(context)!.negotiate} (${negotiatedOffersSubject.value?.length})",
                                      style: AppStyles
                                          .baloo2FontWith500WeightAnd25Size
                                          .copyWith(color: whiteColor),
                                    ),
                                  ),
                                )))
                        : const SizedBox();
                  }),
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
                        Navigator.pop(context);
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (c) => PaymentScreen(
                                      offerId: state.id,
                                    )));
                      });
                    } else {
                      LoadingDialogs.hideLoadingDialog();
                      CoolAlert.show(
                        barrierDismissible: false,
                        context: context,
                        closeOnConfirmBtnTap: true,
                        autoCloseDuration: const Duration(seconds: 3),
                        showOkBtn: false,
                        type: CoolAlertType.error,
                        title: AppLocalizations.of(context)!.error,
                        text:
                            AppLocalizations.of(context)!.something_went_wrong,
                      );
                    }
                  },
                  child: const SizedBox())
            ],
          ),
        ),
      ),
    );
  }

  List<int>? offersNegotiatedIds = [];

  onNegotiatePressed(int id) {
    offersNegotiatedIds!.contains(id)
        ? offersNegotiatedIds!.remove(id)
        : offersNegotiatedIds!.add(id);
    negotiatedOffersSubject.sink.add(offersNegotiatedIds);
  }
}

class OfferCard extends StatelessWidget {
  final NegotiationModel items;
  final Function(int id) onNegotiatePressed, onBookPressed;
  final bool isEnabled;
  final bool isNegotiable;
  final bool? isExpanded;

  const OfferCard(
      {required this.items,
      required this.onNegotiatePressed,
      required this.onBookPressed,
      required this.isEnabled,
      this.isExpanded,
      required this.isNegotiable,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 180.h,
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
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: Padding(
              padding: const EdgeInsets.only(
                  left: 12, right: 12, top: 12, bottom: 12),
              child: Row(
                children: [
                  Column(
                    children: [
                      Container(
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.grey.shade300),
                            image: const DecorationImage(
                              image: AssetImage(personImage),
                            )),
                      ),
                      Row(
                        children: [
                          const Icon(
                            Icons.star,
                            color: Color(0xffEB8B17),
                            size: 16,
                          ),
                          Text(
                            "0.0",
                            style: AppStyles
                                .baloo2FontWith400WeightAnd18SizeAndBlack
                                .copyWith(color: const Color(0xffD8D7D9)),
                          ),
                        ],
                      ),
                      isExpanded != null
                          ? Icon(
                              isExpanded!
                                  ? Icons.keyboard_arrow_up
                                  : Icons.keyboard_arrow_down,
                              color: Colors.grey,
                            )
                          : const SizedBox(),
                    ],
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          items.providerName ?? "",
                          style: AppStyles
                              .baloo2FontWith400WeightAnd18SizeAndBlack,
                        ),
                        const SizedBox(height: 2),
                        Row(
                          children: [
                            const Icon(
                              Icons.location_pin,
                              color: primaryColor,
                            ),
                            Expanded(
                                child: Text(
                              items.distanceInMeter.toString(),
                              style: AppStyles
                                  .baloo2FontWith400WeightAnd18SizeAndBlack,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                            )),
                            Text(
                              "m",
                              style: AppStyles
                                  .baloo2FontWith400WeightAnd18SizeAndBlack,
                            ),
                          ],
                        ),
                        Column(
                          children: [
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
                  const SizedBox(width: 16),
                ],
              ),
            ),
          ),
          isNegotiable && items.insuranceStatus == 0
              ? Expanded(
                  flex: 2,
                  child: Column(
                    children: [
                      Visibility(
                        visible: true,
                        child: Expanded(
                            flex: 1,
                            child: GestureDetector(
                                onTap: () => onNegotiatePressed(items.id ?? 0),
                                child: OffersOptionsButton(
                                  buttonType: ButtonType.negotiate,
                                  title:
                                      AppLocalizations.of(context)!.negotiate,
                                  isEnabled: isEnabled,
                                ))),
                      ),
                      const SizedBox(
                        height: 4,
                      ),
                      Expanded(
                          flex: 1,
                          child: GestureDetector(
                              onTap: () => onBookPressed(items.id ?? 0),
                              child: OffersOptionsButton(
                                  buttonType: ButtonType.book,
                                  title: AppLocalizations.of(context)!.book,
                                  isEnabled: true))),
                    ],
                  ),
                )
              : Expanded(
                  child: GestureDetector(
                      onTap: () => onBookPressed(items.id ?? 0),
                      child: OffersOptionsButton(
                          buttonType: ButtonType.book,
                          title: AppLocalizations.of(context)!.book,
                          isEnabled: true))),
        ],
      ),
    );
  }
}
