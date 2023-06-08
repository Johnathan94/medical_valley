import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:medical_valley/core/app_colors.dart';
import 'package:medical_valley/core/app_sizes.dart';
import 'package:medical_valley/core/app_styles.dart';
import 'package:medical_valley/core/shared_pref/shared_pref.dart';
import 'package:medical_valley/features/home/home_details_screen/persentation/screen/package_details.dart';
import 'package:medical_valley/features/home/home_search_screen/data/models/package_response.dart';
import 'package:medical_valley/features/home/home_search_screen/persentation/bloc/home_bloc.dart';
import 'package:medical_valley/features/home/home_search_screen/persentation/bloc/home_state.dart';
import 'package:rxdart/rxdart.dart';

class PackagesScreen extends StatefulWidget {
  final String categoryName;
  final int categoryId;

  const PackagesScreen(this.categoryName, this.categoryId, {Key? key})
      : super(key: key);

  @override
  State<PackagesScreen> createState() => _PackagesScreenState();
}

class _PackagesScreenState extends State<PackagesScreen> {
  var homeBloc = GetIt.instance<HomeBloc>();
  final PagingController<int, Package> pagingController =
      PagingController(firstPageKey: 1);
  int nextPage = 1;
  int nextPageKey = 1;
  @override
  initState() {
    pagingController.addPageRequestListener((pageKey) {
      nextPageKey = pageKey;
      homeBloc.getPackages(widget.categoryId, nextPage, 10);
      nextPage += 1;
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(
        top: 15,
      ),
      child: BlocListener<HomeBloc, MyHomeState>(
        bloc: homeBloc,
        listener: (context, MyHomeState state) {
          if (state is SuccessPackageState) {
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
        child: PagedListView<int, Package>(
          pagingController: pagingController,
          builderDelegate: PagedChildBuilderDelegate(
            itemBuilder: (context, Package item, index) {
              return buildSearchModelsItem(context, item, index);
            },
          ),
        ),
      ),
    );
  }

  BehaviorSubject<int> selectedService = BehaviorSubject.seeded(-1);

  buildSearchModelsItem(BuildContext context, Package service, int index) {
    return StreamBuilder<int>(
        stream: selectedService.stream,
        builder: (context, snapshot) {
          return GestureDetector(
            onTap: () {
              selectedService.sink.add(service.id!);
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => PackageDetails()));
            },
            child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                height: 60,
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
