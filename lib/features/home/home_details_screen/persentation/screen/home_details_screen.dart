import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:medical_valley/core/app_colors.dart';
import 'package:medical_valley/core/app_styles.dart';

import '../../../../../core/app_sizes.dart';
import '../../../widgets/home_base_app_bar.dart';
import '../../data/models/home_search_model.dart';

class HomeDetailsScreen extends StatefulWidget {
  final String searchScreenTitle;
  const HomeDetailsScreen({Key? key, required this.searchScreenTitle})
      : super(key: key);

  @override
  State<HomeDetailsScreen> createState() => _HomeDetailsScreenState();
}

class _HomeDetailsScreenState extends State<HomeDetailsScreen> {
  late String _screenTitle;
  final List<HomeSearchModel> _searchModels = [];

  @override
  initState() {
    _screenTitle = widget.searchScreenTitle;
    getSearchModels();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: buildBody(),
    );
  }

  buildAppBar() {
    return CustomHomeAppBar(
      isSearchableAppBar: true,
      searchHint: AppLocalizations.of(context)!.search,
      goodMorningText: _screenTitle,
      leadingIcon: InkWell(
        onTap: () => Navigator.pop(context),
        child: const Icon(
          Icons.arrow_back_ios,
          color: whiteColor,
        ),
      ),
      isTwoLineTitle: false,
    );
  }

  var value;
  buildBody() {
    return Container(
      margin: const EdgeInsets.only(
        top: homeSearchScreenMarginTop,
      ),
      child: ListView.builder(
          shrinkWrap: true,
          padding: const EdgeInsets.only(bottom: homeSearchScreenMarginBottom),
          itemCount: _searchModels.length,
          itemBuilder: (context, index) {
            return buildSearchModelsItem(_searchModels[index], index);
          }),
    );
  }

  void getSearchModels() {
    _searchModels.add(HomeSearchModel(1, "Echocardiography", false));
    _searchModels.add(HomeSearchModel(2, "Interventional Cardiology", false));
    _searchModels.add(HomeSearchModel(3, "Pediatric cardiology", false));
    _searchModels.add(HomeSearchModel(4, "Cardiac examination", false));
    _searchModels.add(HomeSearchModel(5, "Heart disorders", false));
    _searchModels.add(HomeSearchModel(6, "Echocardiography", false));
    _searchModels.add(HomeSearchModel(7, "Interventional Cardiology", false));
    _searchModels.add(HomeSearchModel(8, "Pediatric cardiology", false));
    _searchModels.add(HomeSearchModel(9, "Cardiac examination", false));
    _searchModels.add(HomeSearchModel(10, "Heart disorders", false));
  }

  buildSearchModelsItem(HomeSearchModel searchModel, int index) {
    return Container(
      height: homeSearchScreenHeight,
      margin: const EdgeInsetsDirectional.only(
          end: homeSearchScreenMarginHorizontal,
          start: homeSearchScreenMarginHorizontal,
          top: homeSearchItemMarginTop),
      decoration: const BoxDecoration(
          color: whiteColor,
          borderRadius:
              BorderRadius.all(Radius.circular(homeSearchScreenRadius)),
          boxShadow: [
            BoxShadow(spreadRadius: 1, blurRadius: 8, color: shadowColor)
          ]),
      child: RadioListTile(
        activeColor: blackColor,
        controlAffinity: ListTileControlAffinity.trailing,
        value: index,
        groupValue: value,
        onChanged: (newValue) => setState(() => value = newValue),
        title: Text(
          searchModel.name,
          style: AppStyles.baloo2FontWith400WeightAnd12Size,
        ),
      ),
    );
  }
}
