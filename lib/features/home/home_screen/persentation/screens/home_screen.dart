import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medical_valley/core/app_colors.dart';
import 'package:medical_valley/core/app_styles.dart';
import 'package:medical_valley/core/strings/images.dart';
import 'package:medical_valley/features/home/home_details_screen/persentation/screen/home_details_screen.dart';

import '../../../../../core/app_sizes.dart';
import '../../../widgets/home_base_app_bar.dart';
import '../../data/models/service_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => HomeState();
}

class HomeState extends State<HomeScreen> {
  final List<ServiceModel> _services = [];

  @override
  initState() {
    getServices();
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

  buildAppBar() {
    return CustomHomeAppBar(
      isSearchableAppBar: true,
      searchHint: AppLocalizations.of(context)!.search,
      goodMorningText: AppLocalizations.of(context)!.good_morning,
      leadingIcon: Image.asset(
        appIcon,
        width: appBarIconWidth,
        height: appBarIconHeight,
      ),
      isTwoLineTitle: true,
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
    return Container(
      margin: EdgeInsetsDirectional.only(end: homeTitleMarginEnd.w),
      child: GridView.count(
          crossAxisCount: 2,
          childAspectRatio: 1.6,
          children: List.generate(_services.length, (index) {
            return Center(
              child: buildHomeModelItem(_services[index]),
            );
          })),
    );
  }

  void getServices() {
    _services.add(ServiceModel(1, homeModelOneIcon, "Cardiology"));
    _services.add(ServiceModel(2, homeModelTwoIcon, "Ear, nose and Throat"));
    _services
        .add(ServiceModel(3, homeModelOneIcon, "Elderly Services Department"));
    _services.add(ServiceModel(4, homeModelTwoIcon, "Gastroenterology"));
    _services.add(ServiceModel(5, homeModelOneIcon, "Cardiology"));
    _services.add(ServiceModel(6, homeModelTwoIcon, "Gynecology"));
    _services
        .add(ServiceModel(7, homeModelOneIcon, "Elderly Services Department"));
    _services.add(ServiceModel(8, homeModelTwoIcon, "Gastroenterology"));
    _services.add(ServiceModel(9, homeModelOneIcon, "Cardiology"));
    _services.add(ServiceModel(10, homeModelTwoIcon, "Ear, nose and Throat"));
    _services.add(ServiceModel(11, homeModelOneIcon, "Cardiology"));
    _services.add(ServiceModel(12, homeModelTwoIcon, "Ear, nose and Throat"));
  }

  buildHomeModelItem(ServiceModel service) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) =>
                HomeDetailsScreen(searchScreenTitle: service.name)));
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
            Image.asset(service.icon),
            Expanded(
              child: Text(
                service.name,
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
      appBar: buildAppBar(),
      body: getHomeScreen(),
    );
  }
}
