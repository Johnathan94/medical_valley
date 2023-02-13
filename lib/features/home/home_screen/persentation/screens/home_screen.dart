import 'package:cool_alert/cool_alert.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get_it/get_it.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:medical_valley/core/app_colors.dart';
import 'package:medical_valley/features/home/home_search_screen/data/models/categories_model.dart';
import 'package:medical_valley/features/home/home_search_screen/persentation/bloc/home_bloc.dart';
import 'package:medical_valley/features/home/home_search_screen/persentation/bloc/home_state.dart';
import 'package:medical_valley/features/home/widgets/appointment_options_bottom_sheet.dart';

import '../../../../../core/app_sizes.dart';
import '../../../../../core/app_styles.dart';
import '../../../../../core/strings/images.dart';
import '../../../widgets/home_base_app_bar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  HomeBloc homeBloc = GetIt.I<HomeBloc>();
  final PagingController<int, CategoryModel> pagingController =
      PagingController(firstPageKey: 1);
  int nextPage = 1;
  int nextPageKey = 1;
  @override
  initState() {
    homeBloc.getCategories(nextPage, 10);

    pagingController.addPageRequestListener((pageKey) {
      nextPageKey = 10 + nextPage;
      nextPage = pageKey + 1;
      homeBloc.getCategories(nextPage, 10);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: BlocListener<HomeBloc, MyHomeState>(
        bloc: homeBloc,
        listener: (c, state) {
          if (state is SuccessHomeState) {
            if (state.category.data!.results!.length == 10) {
              pagingController.appendPage(
                  state.category.data!.results!, nextPageKey);
            } else {
              pagingController.appendLastPage(state.category.data!.results!);
            }
          } else if (state is ErrorHomeState) {
            CoolAlert.show(
              context: context,
              onConfirmBtnTap: () {
                Navigator.pop(context);
              },
              type: CoolAlertType.error,
              text: AppLocalizations.of(context)!.server_error,
            );
          }
        },
        child: getBody(),
      ),
    );
  }

  buildAppBar() {
    return CustomHomeAppBar(
      isSearchableAppBar: false,
      controller: TextEditingController(),
      goodMorningText: AppLocalizations.of(context)!.good_morning,
      leadingIcon: Image.asset(
        appIcon,
        width: appBarIconWidth,
        height: appBarIconHeight,
      ),
      isTwoLineTitle: true,
    );
  }

  var value;
  Widget getBody() {
    return Container(
        color: whiteColor,
        child: PagedListView<int, CategoryModel>(
          pagingController: pagingController,
          padding:
              const EdgeInsetsDirectional.only(top: 22, start: 27, end: 27),
          builderDelegate: PagedChildBuilderDelegate(
            itemBuilder: (context, CategoryModel item, index) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton2(
                    isExpanded: true,
                    hint: Row(
                      children: [
                        Expanded(
                          child: Text(
                            item.name ?? "",
                            style: AppStyles.headlineStyle,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                    items: item.services!
                        .map((item) => DropdownMenuItem<Services>(
                              value: item,
                              child: RadioListTile(
                                  activeColor: blackColor,
                                  value: index,
                                  groupValue: value,
                                  onChanged: (newValue) {
                                    Navigator.pop(context);
                                    showBottomSheet(
                                        context: context,
                                        builder: (context) =>
                                            const AppointmentsBottomSheet());
                                  },
                                  title: Text(
                                    item.englishName!,
                                    style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  )),
                            ))
                        .toList(),
                    onChanged: (value) {},
                    icon: SvgPicture.asset(arrowRightIcon),
                    buttonHeight: 50,
                    buttonWidth: 160,
                    buttonPadding: const EdgeInsets.only(left: 14, right: 14),
                    buttonDecoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(14),
                      color: whiteColor,
                    ),
                    buttonElevation: 2,
                    itemHeight: 45,
                    itemPadding: const EdgeInsets.only(left: 14, right: 14),
                    dropdownMaxHeight: 200,
                    dropdownWidth: (MediaQuery.of(context).size.width - 54),
                    dropdownPadding: null,
                    dropdownDecoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(14),
                      color: whiteColor,
                    ),
                    dropdownElevation: 8,
                    scrollbarRadius: const Radius.circular(40),
                    scrollbarThickness: 6,
                    scrollbarAlwaysShow: true,
                  ),
                ),
              );
            },
          ),
        ));
  }
}
