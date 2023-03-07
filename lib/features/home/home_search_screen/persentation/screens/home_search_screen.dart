
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
import 'package:medical_valley/features/home/home_search_screen/data/models/categories_model.dart';
import 'package:medical_valley/features/home/home_search_screen/persentation/bloc/home_bloc.dart';
import 'package:medical_valley/features/home/home_search_screen/persentation/bloc/home_state.dart';

import '../../../../../core/app_sizes.dart';
import '../../../widgets/home_base_app_bar.dart';

class HomeSearchScreen extends StatefulWidget {
  const HomeSearchScreen({Key? key}) : super(key: key);

  @override
  State<HomeSearchScreen> createState() => HomeState();
}

class HomeState extends State<HomeSearchScreen> {
  TextEditingController controller = TextEditingController();
  HomeBloc homeBloc = GetIt.I<HomeBloc>();
  final PagingController<int, Services> pagingController =
  PagingController(firstPageKey: 1);
  int nextPage = 1;
  int nextPageKey = 1;
  String keyword = "";
  Map<String , dynamic > currentUser = {} ;

  @override
  initState() {
    pagingController.addPageRequestListener((pageKey) {
      nextPageKey = pageKey;
      homeBloc.searchWithKeyword(keyword,nextPage, 10);
      nextPage += 1;
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

  getHomeScreenWidget() {
    return Container(
      margin: const EdgeInsetsDirectional.only(
        top: homeTitleMarginTop,
      ),
      child: Column(
        children: [
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
      child: Container(
        margin: EdgeInsetsDirectional.only(end: homeTitleMarginEnd.w),
        child: PagedGridView<int , Services>(
            builderDelegate: PagedChildBuilderDelegate<Services>(
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
            ),
      ),
    );
  }

  Widget buildHomeModelItem(Services service) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) =>
                HomeDetailsScreen(searchScreenTitle: service.englishName!)));
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomHomeAppBar(
        username: currentUser["result"]["data"]["fullName"],
        isSearchableAppBar: true,
        searchHint: AppLocalizations.of(context)!.search,
        onSubmit :(String? text){
          nextPage = 1;
          keyword = text!;
          pagingController.refresh();
        },
        goodMorningText: AppLocalizations.of(context)!.good_morning,
        leadingIcon: Image.asset(
          appIcon,
          width: appBarIconWidth,
          height: appBarIconHeight,
        ),
        isTwoLineTitle: true,
        controller: controller,
      ),
      body: getHomeScreen(),
    );
  }
}
