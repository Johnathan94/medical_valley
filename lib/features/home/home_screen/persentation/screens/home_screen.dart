import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:medical_valley/core/app_colors.dart';
import 'package:medical_valley/core/app_styles.dart';
import 'package:medical_valley/core/extensions/string_extensions.dart';
import 'package:medical_valley/core/shared_pref/shared_pref.dart';
import 'package:medical_valley/features/auth/phone_verification/data/model/otp_response_model.dart';
import 'package:medical_valley/features/home/home_details_screen/persentation/screen/home_details_screen.dart';
import 'package:medical_valley/features/home/home_screen/persentation/bloc/book_request_bloc.dart';
import 'package:medical_valley/features/home/home_search_screen/data/models/categories_model.dart';
import 'package:medical_valley/features/home/home_search_screen/persentation/bloc/home_bloc.dart';
import 'package:medical_valley/features/home/home_search_screen/persentation/bloc/home_state.dart';
import 'package:rxdart/rxdart.dart';

import '../../../../../core/app_sizes.dart';
import '../../../../../core/strings/images.dart';
import '../../../widgets/home_base_app_bar.dart';

String iconLinkPrefix = "https://api.medvalley-sa.com/";

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  HomeBloc homeBloc = GetIt.I<HomeBloc>();
  BookRequestBloc bookRequestBloc = GetIt.I<BookRequestBloc>();
  BehaviorSubject<bool> isGridView = BehaviorSubject.seeded(false);
  int nextPage = 1;
  int nextPageKey = 1;
  late UserDate currentUser;
  @override
  initState() {
    homeBloc.getCategories();
    currentUser = UserDate.fromJson(LocalStorageManager.getUser()!);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: BlocBuilder<HomeBloc, MyHomeState>(
        bloc: homeBloc,
        builder: (c, state) {
          if (state is SuccessHomeState) {
            return getBody(state.category.data!);
          }
          if (state is LoadingHomeState) {
            return const Center(child: CircularProgressIndicator());
          } else {
            return const Text("There is no Categories");
          }
        },
      ),
    );
  }

  buildAppBar() {
    return CustomHomeAppBar(
      username: currentUser.fullName!,
      isSearchableAppBar: false,
      hasSearchIcon: true,
      controller: TextEditingController(),
      goodMorningText: getGreeting(context),
      bottom: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            GestureDetector(
                onTap: () => isGridView.sink.add(true),
                child: Container(
                    padding: const EdgeInsets.all(8),
                    margin: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                        boxShadow: const [
                          BoxShadow(
                              color: shadowGrey,
                              offset: Offset(2, 2),
                              spreadRadius: 1,
                              blurRadius: 5)
                        ]),
                    child: const Icon(
                      Icons.grid_4x4,
                      color: primaryColor,
                      size: 25,
                    ))),
            GestureDetector(
                onTap: () => isGridView.sink.add(false),
                child: Container(
                    padding: const EdgeInsets.all(8),
                    margin: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                        boxShadow: const [
                          BoxShadow(
                              color: shadowGrey,
                              offset: Offset(2, 2),
                              spreadRadius: 1,
                              blurRadius: 5)
                        ]),
                    child: const Icon(Icons.list, color: primaryColor))),
          ],
        ),
      ),
      leadingIcon: Image.asset(
        appIcon,
        width: appBarIconWidth,
        height: appBarIconHeight,
      ),
      isTwoLineTitle: true,
      context: context,
      onBackPressed: () {},
    );
  }

  Widget getBody(List<CategoryModel> models) {
    return StreamBuilder<bool>(
        stream: isGridView.stream,
        builder: (context, snapshot) {
          return isGridView.value
              ? GridView.builder(
                  itemCount: models.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 1,
                      mainAxisSpacing: 1,
                      childAspectRatio:
                          MediaQuery.of(context).size.aspectRatio * 3),
                  itemBuilder: (BuildContext context, int index) {
                    return Center(
                      child: _buildCategoryItemForGrid(models[index]),
                    );
                  },
                )
              : Container(
                  color: whiteColor,
                  child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: models.length,
                      padding: EdgeInsets.zero,
                      itemBuilder: (c, index) =>
                          _buildCategoryItem(models[index])));
        });
  }

  _buildCategoryItem(CategoryModel model) {
    return GestureDetector(
      onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
              builder: (c) => HomeDetailsScreen(
                    categoryName:
                        LocalStorageManager.getCurrentLanguage() == "ar"
                            ? model.arabicName ?? ""
                            : model.name ?? "",
                    categoryId: model.id!,
                  ))),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: const [
              BoxShadow(
                  color: Color(0xffE2E2E2),
                  blurRadius: 5,
                  spreadRadius: 2,
                  offset: Offset(2, 2))
            ],
            borderRadius: BorderRadius.circular(16)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                model.icon != null && model.icon!.isNotEmpty
                    ? CachedNetworkImage(
                        imageUrl: iconLinkPrefix + model.icon!,
                        placeholder: (context, url) =>
                            const CircularProgressIndicator(),
                        errorWidget: (context, url, error) =>
                            const Icon(Icons.error),
                        width: 20,
                        height: 20,
                      )
                    : const Icon(Icons.medical_services_outlined,
                        color: Colors.black, size: 20),
                const SizedBox(
                  width: 4,
                ),
                Text(
                  LocalStorageManager.getCurrentLanguage() == "ar"
                      ? model.arabicName!
                      : model.name!,
                  style: AppStyles.baloo2FontWith400WeightAnd18Size.copyWith(
                      color: Colors.black, decoration: TextDecoration.none),
                ),
              ],
            ),
            const Icon(
              Icons.arrow_forward_ios,
              color: Colors.black,
            )
          ],
        ),
      ),
    );
  }

  _buildCategoryItemForGrid(CategoryModel model) {
    return GestureDetector(
      onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
              builder: (c) => HomeDetailsScreen(
                    categoryName: model.name!,
                    categoryId: model.id!,
                  ))),
      child: Container(
        width: MediaQuery.of(context).size.width * .333,
        height: MediaQuery.of(context).size.width * .333,
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: const [
              BoxShadow(
                  color: Color(0xffE2E2E2),
                  blurRadius: 5,
                  spreadRadius: 2,
                  offset: Offset(2, 2))
            ],
            borderRadius: BorderRadius.circular(16)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            model.icon != null && model.icon!.isNotEmpty
                ? CachedNetworkImage(
                    imageUrl: iconLinkPrefix + model.icon!,
                    placeholder: (context, url) =>
                        const CircularProgressIndicator(),
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                    width: 20,
                    height: 20,
                  )
                : const Icon(Icons.medical_services_outlined,
                    color: Colors.black, size: 20),
            const SizedBox(
              height: 8,
            ),
            Text(
              LocalStorageManager.getCurrentLanguage() == "ar"
                  ? model.arabicName!
                  : model.name!,
              style: AppStyles.baloo2FontWith400WeightAnd18Size.copyWith(
                  color: Colors.black,
                  decoration: TextDecoration.none,
                  height: 1.1),
              textAlign: TextAlign.center,
              maxLines: 3,
            ),
          ],
        ),
      ),
    );
  }
}
