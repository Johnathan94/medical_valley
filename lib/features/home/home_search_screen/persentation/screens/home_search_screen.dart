
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it/get_it.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:medical_valley/core/app_colors.dart';
import 'package:medical_valley/core/app_styles.dart';
import 'package:medical_valley/core/shared_pref/shared_pref.dart';
import 'package:medical_valley/core/strings/images.dart';
import 'package:medical_valley/features/home/home_details_screen/persentation/screen/home_details_screen.dart';
import 'package:medical_valley/features/home/home_screen/data/book_request_model.dart';
import 'package:medical_valley/features/home/home_screen/persentation/bloc/book_request_bloc.dart';
import 'package:medical_valley/features/home/home_screen/persentation/screens/calender_screen.dart';
import 'package:medical_valley/features/home/home_search_screen/data/models/services_model.dart';
import 'package:medical_valley/features/home/home_search_screen/persentation/bloc/home_bloc.dart';
import 'package:medical_valley/features/home/home_search_screen/persentation/bloc/home_state.dart';
import 'package:medical_valley/features/home/widgets/appointment_options_bottom_sheet.dart';
import 'package:rxdart/rxdart.dart';

import '../../../../../core/app_sizes.dart';
import '../../../widgets/home_base_app_bar.dart';

class HomeSearchScreen extends StatefulWidget {
  final Function isBackPressed ;

  const HomeSearchScreen({required this.isBackPressed , Key? key}) : super(key: key);

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
  Map<String , dynamic > currentUser = {} ;
  bool isSearchStarted = false ;
  @override
  initState() {
    pagingController.addPageRequestListener((pageKey) {
      if (isSearchStarted ) {
        nextPageKey = pageKey;
        homeBloc.searchWithKeyword(keyword,nextPage, 10);
        nextPage += 1;
      }

    });
    String user = LocalStorageManager.getUser();
    currentUser =  jsonDecode(user);
    super.initState();
  }

  getHomeScreen() {
    return Container(
      height: screenHeight,
      width: screenWidth,
      color: whiteColor,
      child: getHomeScreenWidget(),
    );
  }
  BehaviorSubject<bool> gridSubject = BehaviorSubject.seeded(true);
  getHomeScreenWidget() {
    return Container(
      margin: const EdgeInsetsDirectional.only(
        top: 10,
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children:  [
              GestureDetector(
                  onTap: ()=> gridSubject.sink.add(true),
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    margin: const EdgeInsets.all(8),
                      decoration:  BoxDecoration(

                        color: Colors.white,
                        borderRadius:  BorderRadius.circular(8),
                        boxShadow:  const [
                          BoxShadow(
                            color:shadowGrey,
                            offset: Offset(2, 2),
                            spreadRadius: 1,
                            blurRadius: 5
                          )
                        ]
                      ),
                      child: const Icon(Icons.grid_4x4 , color: primaryColor,size: 25,))) ,
              GestureDetector(
                  onTap: ()=> gridSubject.sink.add(false),
                  child: Container(
                      padding: const EdgeInsets.all(8),
                      margin: const EdgeInsets.all(8),
                      decoration:  BoxDecoration(
                          color: Colors.white,
                          borderRadius:  BorderRadius.circular(8),
                          boxShadow:  const [
                            BoxShadow(
                                color:shadowGrey,
                                offset: Offset(2, 2),
                                spreadRadius: 1,
                                blurRadius: 5
                            )
                          ]
                      ),
                      child: const Icon(Icons.list,color: primaryColor))),
            ],
          ),
          buildHomeTitle(),
          Expanded(child: buildHomeTitleGridView()),
          const SizedBox(
            height: 10,
          )
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

  buildHomeTitleGridView() {
    return BlocListener<HomeBloc , MyHomeState>(
      bloc: homeBloc,
      listener: (context, state) {
        if(state is SearchResultState)
       {
         if(state.searchResult.data!.results!.length == 10){
           pagingController.appendPage(state.searchResult.data!.results!, nextPageKey);
         }else {
           pagingController.appendLastPage(state.searchResult.data!.results!);
         }
      }
      },
      child: StreamBuilder<bool>(
        stream: gridSubject.stream,
        builder: (context, snapshot) {
          return gridSubject.value ?
           PagedGridView<int , Service>(
              builderDelegate: PagedChildBuilderDelegate<Service>(
                itemBuilder: (c , item , index){
                  return Center(
                    child: buildHomeModelItem(item),
                  );
                }
              ),
              pagingController: pagingController,
            gridDelegate:  SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 1,
              mainAxisSpacing: 1,
              childAspectRatio: MediaQuery.of(context).size.aspectRatio * 3
            ),
              ) :
          PagedListView<int , Service>(
            builderDelegate: PagedChildBuilderDelegate<Service>(
                itemBuilder: (c , item , index){
                  return buildSearchModelsItem(context , item ,index );
                }
            ),
            pagingController: pagingController,
          );
        }
      ),
    );
  }

  Widget buildHomeModelItem(Service service) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) =>
                HomeDetailsScreen(categoryName: service.englishName!, categoryId: 1,)));
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
                service.englishName?? "",
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
  buildSearchModelsItem(BuildContext context ,Service service, int index) {
    return GestureDetector(
      onTap: (){
        showBottomSheet(
            context: context,
            builder: (context) => AppointmentsBottomSheet(
              onBookRequest: (int id) async {
                if (id == 1 || id == 2) {
                  String user = LocalStorageManager.getUser();
                  Map<String, dynamic> result = jsonDecode(user);
                  bookRequestBloc.requestBook(BookRequestModel(
                      serviceId: service.id!,
                     // categoryId: service.categoryName,
                      bookingTypeId: id,
                      userId: result["id"]));
                }
              },
              onScheduledPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (c) => CalenderScreen(
                          services: service,
                        )));
              },
            ));
      },
      child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          height: homeSearchScreenHeight,
          margin: const EdgeInsetsDirectional.only(
              end: 16,
              start: 16,
              top: homeSearchItemMarginTop),
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
                  service.englishName ?? "",
                  maxLines: 2,
                  style: AppStyles.baloo2FontWith400WeightAnd12Size,
                ),
              ),
              const Expanded(
                  flex: 10,
                  child:  Icon(Icons.circle_outlined))
            ],
          )
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomHomeAppBar(
        username: currentUser["data"]["data"]["fullName"],
        isSearchableAppBar: true,
        searchHint: AppLocalizations.of(context)!.search,
        onSubmit :(String? text){
          nextPage = 1;
          keyword = text!;
          isSearchStarted = true ;
          pagingController.refresh();
          pagingController.notifyPageRequestListeners(nextPage);
        },
        onBackPressed : (){
          widget.isBackPressed();
        } ,
        goodMorningText: AppLocalizations.of(context)!.good_morning,
        leadingIcon: Image.asset(
          appIcon,
          width: appBarIconWidth,
          height: appBarIconHeight,
        ),
        isTwoLineTitle: true,
        controller: controller, context: context,
      ),
      body: getHomeScreen(),
    );
  }
}
