import 'package:cool_alert/cool_alert.dart';
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
import 'package:medical_valley/features/offers/presentation/presentation/success_screen.dart';
import 'package:medical_valley/features/offers/widgets/offers_options_button.dart';
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
  final PagingController<int, NegotiationModel> pagingController =
      PagingController(firstPageKey: 1);
  int nextPage = 1;
  int nextPageKey = 1;

  @override
  void initState() {
    //offersBloc.getOffers(OffersEvent(nextPage, 10 , 24509  , 11));
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

  BehaviorSubject<int> rxNegotiateCount = BehaviorSubject();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
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
                    if (state.offersResponse.data!.results!.length == 10) {
                      pagingController.appendPage(
                          state.offersResponse.data!.results!, nextPageKey);
                    } else {
                      if (pagingController.value.itemList !=
                          state.offersResponse.data!.results) {
                        pagingController.appendLastPage(
                            state.offersResponse.data!.results!);
                      }
                    }
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 60.0),
                      child: StreamBuilder<List<int>?>(
                          stream: negotiatedOffersSubject.stream,
                          builder: (context, snapshot) {
                            return PagedListView<int, NegotiationModel>(
                              pagingController: pagingController,
                              builderDelegate: PagedChildBuilderDelegate(
                                itemBuilder:
                                    (context, NegotiationModel item, index) {
                                  return StreamBuilder<int>(
                                      stream: rxNegotiateCount.stream,
                                      builder: (context, snapshot) {
                                        return OfferCard(
                                          negoCount: rxNegotiateCount.hasValue
                                              ? rxNegotiateCount.value
                                              : 0,
                                          items: item,
                                          onNegotiatePressed:
                                              onNegotiatePressed,
                                          onBookPressed: (int? id) {
                                            negotiateBloc
                                                .verifyRequest(id ?? 0);
                                          },
                                          isEnabled: !offersNegotiatedIds!
                                              .contains(item.id),
                                        );
                                      });
                                },
                              ),
                            );
                          }),
                    );
                  } else {
                    return Center(child: Text((state as OffersStateError).err));
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
                                  LocalStorageManager.saveNegotiationCount();
                                  rxNegotiateCount.sink.add(LocalStorageManager
                                      .getNegotiationCount());
                                  CoolAlert.show(
                                    barrierDismissible: false,
                                    context: context,
                                    autoCloseDuration:
                                        const Duration(seconds: 1),
                                    showOkBtn: false,
                                    type: CoolAlertType.success,
                                    text: AppLocalizations.of(context)!
                                        .negotiate_successed,
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
                                  LoadingDialogs.hideLoadingDialog();
                                  CoolAlert.show(
                                      barrierDismissible: false,
                                      context: context,
                                      type: CoolAlertType.error,
                                      text: state.error,
                                      autoCloseDuration:
                                          const Duration(seconds: 1),
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
                      text: AppLocalizations.of(context)!.booked_done,
                    );
                    Future.delayed(const Duration(seconds: 2), () async {
                      Navigator.pop(context);
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (c) => const SuccessScreen()));
                    });
                  } else {
                    LoadingDialogs.hideLoadingDialog();
                    CoolAlert.show(
                      barrierDismissible: false,
                      context: context,
                      closeOnConfirmBtnTap: true,
                      autoCloseDuration: const Duration(seconds: 1),
                      showOkBtn: false,
                      type: CoolAlertType.error,
                      text: AppLocalizations.of(context)!.something_went_wrong,
                    );
                  }
                },
                child: const SizedBox())
          ],
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
  final int negoCount;

  const OfferCard(
      {required this.items,
      required this.negoCount,
      required this.onNegotiatePressed,
      required this.onBookPressed,
      required this.isEnabled,
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
          items.insuranceStatus == 0
              ? Expanded(
                  flex: 2,
                  child: Column(
                    children: [
                      Visibility(
                        visible:
                            items.insuranceStatus == 0 && 3 - negoCount != 0,
                        child: Expanded(
                            flex: 2 - negoCount,
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
                          flex: negoCount + 1,
                          child: GestureDetector(
                              onTap: () => onBookPressed(items.requestId ?? 0),
                              child: OffersOptionsButton(
                                  buttonType: ButtonType.book,
                                  title: AppLocalizations.of(context)!.book,
                                  isEnabled: isEnabled))),
                    ],
                  ),
                )
              : Expanded(
                  child: GestureDetector(
                      onTap: () => onBookPressed(items.requestId ?? 0),
                      child: OffersOptionsButton(
                          buttonType: ButtonType.book,
                          title: AppLocalizations.of(context)!.book,
                          isEnabled: isEnabled))),
        ],
      ),
    );
  }
}
