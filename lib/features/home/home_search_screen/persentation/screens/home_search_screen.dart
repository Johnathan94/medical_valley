import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it/get_it.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:medical_valley/core/app_colors.dart';
import 'package:medical_valley/core/app_styles.dart';
import 'package:medical_valley/core/dialogs/loading_dialog.dart';
import 'package:medical_valley/core/extensions/string_extensions.dart';
import 'package:medical_valley/core/shared_pref/shared_pref.dart';
import 'package:medical_valley/core/strings/images.dart';
import 'package:medical_valley/features/auth/phone_verification/data/model/otp_response_model.dart';
import 'package:medical_valley/features/home/home_details_screen/persentation/screen/home_details_screen.dart';
import 'package:medical_valley/features/home/home_screen/data/book_request_model.dart';
import 'package:medical_valley/features/home/home_screen/persentation/bloc/book_request_bloc.dart';
import 'package:medical_valley/features/home/home_screen/persentation/screens/calender_screen.dart';
import 'package:medical_valley/features/home/home_search_screen/data/models/services_model.dart';
import 'package:medical_valley/features/home/home_search_screen/persentation/bloc/home_bloc.dart';
import 'package:medical_valley/features/home/home_search_screen/persentation/bloc/home_state.dart';
import 'package:medical_valley/features/home/widgets/appointment_options_bottom_sheet.dart';

import '../../../../../core/app_sizes.dart';
import '../../../../offers/presentation/offers_screen.dart';
import '../../../widgets/home_base_app_bar.dart';

class HomeSearchScreen extends StatefulWidget {
  final Function isBackPressed;

  const HomeSearchScreen({required this.isBackPressed, Key? key})
      : super(key: key);

  @override
  State<HomeSearchScreen> createState() => HomeState();
}

class HomeState extends State<HomeSearchScreen> {
  TextEditingController controller = TextEditingController();
  HomeBloc homeBloc = GetIt.I<HomeBloc>();
  BookRequestBloc bookRequestBloc = GetIt.I<BookRequestBloc>();
  final PagingController<int, Service> pagingController =
      PagingController(firstPageKey: 1);
  int nextPage = 1;
  int nextPageKey = 1;
  String keyword = "";
  late UserDate currentUser;
  bool isSearchStarted = false;
  @override
  initState() {
    pagingController.addPageRequestListener((pageKey) {
      if (isSearchStarted) {
        nextPageKey = pageKey;
        homeBloc.searchWithKeyword(keyword, nextPage, 10);
        nextPage += 1;
      }
    });
    currentUser = UserDate.fromJson(LocalStorageManager.getUser()!);
    super.initState();
  }

  getHomeScreen(context) {
    return Container(
      height: double.infinity,
      width: double.infinity,
      color: whiteColor,
      child: getHomeScreenWidget(context),
    );
  }

  getHomeScreenWidget(context) {
    return Container(
      margin: const EdgeInsetsDirectional.only(
        top: 10,
      ),
      child: Column(
        children: [
          buildHomeTitle(),
          Expanded(child: buildHomeTitleGridView(context)),
          const SizedBox(
            height: 10,
          ),
          BlocListener<BookRequestBloc, BookRequestState>(
            bloc: bookRequestBloc,
            listener: (context, state) {
              if (state.state == BookedState.loading) {
                Navigator.pop(context);
                LoadingDialogs.showLoadingDialog(context);
              } else if (state.state == BookedState.success) {
                LoadingDialogs.hideLoadingDialog();
                CoolAlert.show(
                  barrierDismissible: false,
                  context: context,
                  autoCloseDuration: const Duration(seconds: 1),
                  showOkBtn: false,
                  type: CoolAlertType.success,
                  title: AppLocalizations.of(context)!.success,
                  text: AppLocalizations.of(context)!.request_sent,
                );
                Future.delayed(const Duration(seconds: 2), () async {
                  Navigator.push(
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
                    closeOnConfirmBtnTap: true,
                    type: CoolAlertType.error,
                    autoCloseDuration: const Duration(seconds: 1),
                    showOkBtn: false,
                    text: state.error,
                    title: AppLocalizations.of(context)!.error);
              }
            },
            child: Container(),
          ),
        ],
      ),
    );
  }

  buildHomeTitle() {
    return Text(
      AppLocalizations.of(context)!.how_we_serve_you,
      style: AppStyles.baloo2FontWith500WeightAnd25Size,
    );
  }

  buildHomeTitleGridView(context) {
    return BlocListener<HomeBloc, MyHomeState>(
        bloc: homeBloc,
        listener: (context, state) {
          if (state is SearchResultState) {
            if (state.searchResult.data!.results!.length == 10) {
              pagingController.appendPage(
                  state.searchResult.data!.results!, nextPageKey);
            } else {
              pagingController
                  .appendLastPage(state.searchResult.data!.results!);
            }
          }
        },
        child: PagedListView<int, Service>(
          builderDelegate: PagedChildBuilderDelegate<Service>(
            firstPageProgressIndicatorBuilder: (c) => Center(
                child: Text(
                    AppLocalizations.of(context)!.there_is_no_search_result)),
            itemBuilder: (c, item, index) {
              return buildSearchModelsItem(context, item, index);
            },
            noItemsFoundIndicatorBuilder: (BuildContext context) {
              return Center(
                child: Text(
                    AppLocalizations.of(context)!.there_is_no_search_result),
              );
            },
          ),
          pagingController: pagingController,
        ));
  }

  Widget buildHomeModelItem(Service service) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => HomeDetailsScreen(
                  categoryName: service.englishName!,
                  categoryId: 1,
                )));
      },
      child: Container(
        height: homeModelItemHeight.h,
        width: homeModelItemWidth.w,
        margin: EdgeInsetsDirectional.only(
            start: homeTitleMarginStart.w, end: homeTitleMarginEnd.w),
        padding: EdgeInsetsDirectional.only(start: 11.w, top: 9.h, end: 45.w),
        decoration: const BoxDecoration(
            color: whiteColor,
            borderRadius:
                BorderRadius.all(Radius.circular(homeModelItemRadius)),
            boxShadow: [
              BoxShadow(
                blurRadius: 9,
                spreadRadius: -1,
                color: shadowColor,
              )
            ]),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(homeModelOneIcon),
            Expanded(
              child: Text(
                service.englishName ?? "",
                style: AppStyles.baloo2FontWith400WeightAnd18SizeAndBlack,
              ),
            ),
            SizedBox(
              height: 10.h,
            )
          ],
        ),
      ),
    );
  }

  buildSearchModelsItem(BuildContext ctx, Service service, int index) {
    return GestureDetector(
      onTap: () {
        showModalBottomSheet(
            context: context,
            builder: (_) => AppointmentsBottomSheet(
                  onBookRequest: (int id) async {
                    if (id == 1 || id == 2) {
                      UserDate result =
                          UserDate.fromJson(LocalStorageManager.getUser()!);
                      bookRequestBloc.sendRequest(BookRequestModel(
                          serviceId: service.id!,
                          categoryId: service.categoryId,
                          bookingTypeId: id,
                          isProviderService: false,
                          userId: result.id));
                    }
                  },
                  onScheduledPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (c) => CalenderScreen(
                                  services: service,
                                  isProviderService: false,
                                )));
                  },
                  serviceName: LocalStorageManager.getCurrentLanguage() == "ar"
                      ? service.arabicName ?? ""
                      : service.englishName ?? "",
                ));
      },
      child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          height: homeSearchScreenHeight,
          margin: const EdgeInsetsDirectional.only(
              end: 16, start: 16, top: homeSearchItemMarginTop),
          decoration: const BoxDecoration(
              color: whiteColor,
              borderRadius:
                  BorderRadius.all(Radius.circular(homeSearchScreenRadius)),
              boxShadow: [
                BoxShadow(spreadRadius: 1, blurRadius: 8, color: shadowColor)
              ]),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                flex: 90,
                child: Text(
                  LocalStorageManager.getCurrentLanguage() == "ar"
                      ? service.arabicName ?? ""
                      : service.englishName ?? "",
                  maxLines: 2,
                  style: AppStyles.baloo2FontWith400WeightAnd12Size,
                ),
              ),
              const Expanded(flex: 10, child: Icon(Icons.circle_outlined))
            ],
          )),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomHomeAppBar(
        username: currentUser.fullName ?? "",
        isSearchableAppBar: true,
        searchHint: AppLocalizations.of(context)!.search,
        onSubmit: (String? text) {
          nextPage = 1;
          keyword = text!;
          isSearchStarted = true;
          pagingController.refresh();
          pagingController.notifyPageRequestListeners(nextPage);
        },
        onBackPressed: () {
          widget.isBackPressed();
        },
        goodMorningText: getGreeting(context),
        leadingIcon: Image.asset(
          appIcon,
          width: appBarIconWidth,
          height: appBarIconHeight,
        ),
        isTwoLineTitle: true,
        controller: controller,
        context: context,
        hasSearchIcon: false,
      ),
      body: getHomeScreen(context),
    );
  }
}
