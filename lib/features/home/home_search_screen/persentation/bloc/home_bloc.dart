import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medical_valley/core/base_service/network_error.dart';
import 'package:medical_valley/features/home/home_search_screen/data/models/categories_model.dart';
import 'package:medical_valley/features/home/home_search_screen/data/models/package_response.dart';
import 'package:medical_valley/features/home/home_search_screen/data/models/search_result.dart';
import 'package:medical_valley/features/home/home_search_screen/data/models/services_model.dart';
import 'package:medical_valley/features/home/home_search_screen/domain/get_categories_use_case.dart';
import 'package:medical_valley/features/home/home_search_screen/domain/search_with_keyword.dart';
import 'package:medical_valley/features/home/home_search_screen/persentation/bloc/home_state.dart';

class HomeBloc extends Cubit<MyHomeState> {
  GetCategoriesUseCase getCategoriesUseCase;
  SearchWithKeyboard searchWithKeyboard;

  HomeBloc(this.getCategoriesUseCase, this.searchWithKeyboard)
      : super(InitialHomeState());

  getCategories() async {
    try {
      emit(LoadingHomeState());
      CategoryResponse category = await getCategoriesUseCase.getCategories();
      emit(SuccessHomeState(category));
    } catch (e) {
      emit(ErrorHomeState(ErrorStates.serverError));
    }
  }

  getServices(int categoryId, int pageNumber, int pageSize) async {
    try {
      emit(LoadingServicesState());
      ServicesResponse servicesResponse = await getCategoriesUseCase
          .getServices(categoryId, pageNumber, pageSize);
      emit(SuccessServicesState(servicesResponse));
    } catch (e) {
      emit(ErrorServicesState(ErrorStates.serverError));
    }
  }

  getPackages(int categoryId, int pageNumber, int pageSize) async {
    try {
      emit(LoadingPackageState());
      PackageResponse packageResponse = await getCategoriesUseCase.getPackages(
          categoryId, pageNumber, pageSize);
      emit(SuccessPackageState(packageResponse));
    } catch (e) {
      emit(ErrorPackageState(ErrorStates.serverError));
    }
  }

  searchWithKeyword(String keyword, int page, int pageSize) async {
    try {
      emit(LoadingHomeState());
      SearchResult result =
          await searchWithKeyboard.searchWithKeyword(keyword, page, pageSize);
      emit(SearchResultState(result));
    } catch (e) {
      emit(ErrorHomeState(ErrorStates.serverError));
    }
  }
}
