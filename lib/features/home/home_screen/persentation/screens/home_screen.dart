import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:medical_valley/core/app_colors.dart';
import 'package:medical_valley/core/app_styles.dart';
import 'package:medical_valley/core/strings/images.dart';
import 'package:medical_valley/features/home/widgets/home_base_stateful_widget.dart';

import '../../../../../core/app_sizes.dart';
import '../../../widgets/home_base_app_bar.dart';
import '../../data/models/service_model.dart';

class HomeScreen extends HomeBaseStatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => HomeState();
}

class HomeState extends HomeBaseStatefulWidgetState {
  final List<ServiceModel> _services = [];

  @override
  initState() {
    getServices();
    super.initState();
  }

  @override
  getBody() {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      color: whiteColor,
      child: getHomeScreenWidget(),
    );
  }

  @override
  buildAppBar() {
    return CustomHomeAppBar(
      isSearchableAppBar: true,
      searchHint: AppLocalizations.of(context)!.search,
      goodMorningText: AppLocalizations.of(context)!.good_morning,
    );
  }

  getHomeScreenWidget() {
    return Container(
      margin: const EdgeInsetsDirectional.only(
          top: homeTitleMarginTop,
          start: homeTitleMarginHorizontal,
          end: homeTitleMarginHorizontal),
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
    return GridView.count(
        crossAxisCount: 2,
        childAspectRatio: 1.45,
        crossAxisSpacing: 22,
        children: List.generate(_services.length, (index) {
          return Center(
            child: buildHomeModelItem(_services[index]),
          );
        }));
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
    return Container(
      height: homeModelItemHeight,
      width: homeModelItemWidth,
      padding: const EdgeInsetsDirectional.only(start: 11, top: 9, end: 53),
      decoration: const BoxDecoration(
          color: whiteColor,
          borderRadius: BorderRadius.all(Radius.circular(homeModelItemRadius)),
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
          )
        ],
      ),
    );
  }
}
