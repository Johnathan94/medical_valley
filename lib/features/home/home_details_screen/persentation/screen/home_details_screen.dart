import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get_it/get_it.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:medical_valley/core/app_colors.dart';
import 'package:medical_valley/core/app_styles.dart';
import 'package:medical_valley/core/dialogs/loading_dialog.dart';
import 'package:medical_valley/core/shared_pref/shared_pref.dart';
import 'package:medical_valley/core/widgets/snackbars.dart';
import 'package:medical_valley/features/auth/phone_verification/data/model/otp_response_model.dart';
import 'package:medical_valley/features/home/home_details_screen/persentation/screen/packages_screen.dart';
import 'package:medical_valley/features/home/home_screen/data/book_request_model.dart';
import 'package:medical_valley/features/home/home_screen/persentation/bloc/book_request_bloc.dart';
import 'package:medical_valley/features/home/home_screen/persentation/screens/calender_screen.dart';
import 'package:medical_valley/features/home/home_search_screen/data/models/services_model.dart';
import 'package:medical_valley/features/home/home_search_screen/persentation/bloc/home_bloc.dart';
import 'package:medical_valley/features/home/home_search_screen/persentation/bloc/home_state.dart';
import 'package:medical_valley/features/home/widgets/appointment_options_bottom_sheet.dart';
import 'package:medical_valley/features/offers/presentation/offers_screen.dart';
import 'package:rxdart/rxdart.dart';

import '../../../../../core/app_sizes.dart';

class HomeDetailsScreen extends StatefulWidget {
  final String categoryName;
  final int categoryId;

  const HomeDetailsScreen({
    Key? key,
    required this.categoryName,
    required this.categoryId,
  }) : super(key: key);

  @override
  State<HomeDetailsScreen> createState() => _HomeDetailsScreenState();
}

class _HomeDetailsScreenState extends State<HomeDetailsScreen> {
  late String categoryTitle;
  HomeBloc homeBloc = GetIt.I<HomeBloc>();

  final PagingController<int, Service> pagingController =
      PagingController(firstPageKey: 1);
  int nextPage = 1;
  int nextPageKey = 1;
  BookRequestBloc bookRequestBloc = GetIt.I<BookRequestBloc>();

  @override
  initState() {
    categoryTitle = widget.categoryName;
    pagingController.addPageRequestListener((pageKey) {
      nextPageKey = pageKey;
      homeBloc.getServices(widget.categoryId, nextPage, 10);
      nextPage += 1;
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
          appBar: buildAppBar(),
          body: TabBarView(
            children: [
              BlocListener<BookRequestBloc, BookRequestState>(
                bloc: bookRequestBloc,
                listener: (context, state) {
                  if (state.state == BookedState.loading) {
                    Navigator.pop(context);
                    LoadingDialogs.showLoadingDialog(context);
                  } else if (state.state == BookedState.success) {
                    LoadingDialogs.hideLoadingDialog();
                    context.showSnackBar(
                        AppLocalizations.of(context)!.request_sent);
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (c) => OffersScreen(
                                  requestId: state.requestId!,
                                )));
                  } else {
                    LoadingDialogs.hideLoadingDialog();
                    CoolAlert.show(
                      barrierDismissible: false,
                      context: context,
                      autoCloseDuration: const Duration(seconds: 1),
                      type: CoolAlertType.error,
                      text: state.error,
                    );
                  }
                },
                child: buildBody(),
              ),
              PackagesScreen(widget.categoryName, widget.categoryId),
            ],
          )),
    );
  }

  buildAppBar() {
    return AppBar(
      title: Text(categoryTitle),
      centerTitle: true,
      bottom: TabBar(
        indicatorColor: Colors.white, //<-- SEE HERE
        tabs: [
          Tab(
            text: AppLocalizations.of(context)!.services,
          ),
          Tab(
            text: AppLocalizations.of(context)!.packages,
          ),
        ],
      ),
      leading: InkWell(
        onTap: () => Navigator.pop(context),
        child: const Icon(
          Icons.arrow_back_ios,
          color: whiteColor,
        ),
      ),
      backgroundColor: primaryColor,
    );
  }

  var value;

  Widget buildBody() {
    return Container(
      margin: const EdgeInsets.only(
        top: homeSearchScreenMarginTop,
      ),
      child: BlocListener<HomeBloc, MyHomeState>(
        bloc: homeBloc,
        listener: (context, MyHomeState state) {
          if (state is SuccessServicesState) {
            if (state.response.data!.results!.length == 10) {
              pagingController.appendPage(
                  state.response.data!.results!, nextPageKey);
            } else {
              if (pagingController.value.itemList !=
                  state.response.data!.results) {
                pagingController.appendLastPage(state.response.data!.results!);
              }
            }
          }
        },
        child: PagedListView<int, Service>(
          pagingController: pagingController,
          builderDelegate: PagedChildBuilderDelegate(
            itemBuilder: (context, Service item, index) {
              return buildSearchModelsItem(context, item, index);
            },
          ),
        ),
      ),
    );
  }

  BehaviorSubject<int> selectedService = BehaviorSubject.seeded(-1);
  buildSearchModelsItem(BuildContext context, Service service, int index) {
    return StreamBuilder<int>(
        stream: selectedService.stream,
        builder: (context, snapshot) {
          return GestureDetector(
            onTap: () {
              selectedService.sink.add(service.id!);
              showBottomSheet(
                  context: context,
                  builder: (context) => AppointmentsBottomSheet(
                        serviceName:
                            LocalStorageManager.getCurrentLanguage() == "ar"
                                ? service.arabicName ?? ""
                                : service.englishName ?? "",
                        onBookRequest: (int id) async {
                          if (id == 1 || id == 2) {
                            UserDate result = UserDate.fromJson(
                                LocalStorageManager.getUser()!);
                            bookRequestBloc.sendRequest(BookRequestModel(
                                serviceId: service.id!,
                                isProviderService:
                                    service.isProviderService ?? false,
                                categoryId: widget.categoryId,
                                bookingTypeId: id,
                                userId: result.id));
                          }
                        },
                        onScheduledPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (c) => CalenderScreen(
                                        services: service,
                                        isProviderService:
                                            service.isProviderService ?? false,
                                      )));
                        },
                      ));
            },
            child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                height: homeSearchScreenHeight,
                margin: const EdgeInsetsDirectional.only(
                    end: homeSearchScreenMarginHorizontal,
                    start: homeSearchScreenMarginHorizontal,
                    top: homeSearchItemMarginTop),
                decoration: const BoxDecoration(
                    color: whiteColor,
                    borderRadius: BorderRadius.all(
                        Radius.circular(homeSearchScreenRadius)),
                    boxShadow: [
                      BoxShadow(
                          spreadRadius: 1, blurRadius: 8, color: shadowColor)
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
                    selectedService.value == service.id
                        ? const Expanded(
                            flex: 10,
                            child: Icon(
                              Icons.circle,
                              color: primaryColor,
                            ))
                        : const Expanded(
                            flex: 10, child: Icon(Icons.circle_outlined))
                  ],
                )),
          );
        });
  }
}
