import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get_it/get_it.dart';
import 'package:medical_valley/core/app_colors.dart';
import 'package:medical_valley/core/app_styles.dart';
import 'package:medical_valley/core/shared_pref/shared_pref.dart';
import 'package:medical_valley/features/home/home_details_screen/persentation/screen/home_details_screen.dart';
import 'package:medical_valley/features/home/home_screen/persentation/bloc/book_request_bloc.dart';
import 'package:medical_valley/features/home/home_search_screen/data/models/categories_model.dart';
import 'package:medical_valley/features/home/home_search_screen/persentation/bloc/home_bloc.dart';
import 'package:medical_valley/features/home/home_search_screen/persentation/bloc/home_state.dart';

import '../../../../../core/app_sizes.dart';
import '../../../../../core/strings/images.dart';
import '../../../widgets/home_base_app_bar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  HomeBloc homeBloc = GetIt.I<HomeBloc>();
  BookRequestBloc bookRequestBloc = GetIt.I<BookRequestBloc>();

  int nextPage = 1;
  int nextPageKey = 1;
  Map<String , dynamic > currentUser = {} ;
  @override
  initState() {
    homeBloc.getCategories();
    String user = LocalStorageManager.getUser();
    currentUser =  jsonDecode(user);
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
            return const Center(child:  CircularProgressIndicator());
          } else  {
            return const Text("There is no Categories");
          }
        },
      ),
    );
  }

  buildAppBar() {
    return CustomHomeAppBar(
      username : currentUser["result"]["data"]["fullName"],
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
  Widget getBody(List<CategoryModel> models) {
    return   Container(
          color: whiteColor,
          child: ListView.builder(
              itemCount: models.length,
              padding: EdgeInsets.zero,
              itemBuilder: (c , index)=> _buildCategoryItem(models[index]))
    );
  }

  _buildCategoryItem(CategoryModel model) {
    return  GestureDetector(
      onTap: ()=> Navigator.push(context, MaterialPageRoute(builder: (c)=> HomeDetailsScreen(categoryName: model.name!, categoryId: model.id!,))),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8 , vertical: 12),
        margin: const EdgeInsets.symmetric(horizontal: 20 , vertical: 10),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: const [
            BoxShadow(
              color: Color(0xffE2E2E2),
              blurRadius: 5,
              spreadRadius: 2,
              offset: Offset(2, 2)
            )
          ],
          borderRadius: BorderRadius.circular(16)
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                const Icon(Icons.medical_services_outlined , color: Colors.black,),
                const SizedBox(width: 4,),
                Text(model.name!,style:  AppStyles.baloo2FontWith400WeightAnd18Size.copyWith(color: Colors.black, decoration: TextDecoration.none), ),
              ],
            ),
            const Icon(Icons.arrow_forward_ios , color: Colors.black,)
          ],
        ),
      ),
    );
  }
}
