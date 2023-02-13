import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medical_valley/core/base_service/network_error.dart';
import 'package:medical_valley/features/home/home_search_screen/data/models/categories_model.dart';
import 'package:medical_valley/features/home/home_search_screen/data/models/search_result.dart';
import 'package:medical_valley/features/home/home_search_screen/domain/get_categories_use_case.dart';
import 'package:medical_valley/features/home/home_search_screen/domain/search_with_keyword.dart';
import 'package:medical_valley/features/home/home_search_screen/persentation/bloc/home_state.dart';

class HomeBloc extends Cubit<MyHomeState> {
  GetCategoriesUseCase getCategoriesUseCase;
  SearchWithKeyboard searchWithKeyboard;

  HomeBloc(this.getCategoriesUseCase,this.searchWithKeyboard) : super(InitialHomeState());

  getCategories(int page, int pageSize) async {
    try {
      emit(LoadingHomeState());
     CategoryResponse category = await  getCategoriesUseCase.getCategories(page, pageSize);
      emit(SuccessHomeState(category));
    } catch (e) {
      emit(ErrorHomeState(ErrorStates.serverError));
    }
  }
  searchWithKeyword(String keyword ,int page, int pageSize) async {
    try {
      emit(LoadingHomeState());
     SearchResult result = await  searchWithKeyboard.searchWithKeyword(keyword, page, pageSize);
      emit(SearchResultState(result));
    } catch (e) {
      emit(ErrorHomeState(ErrorStates.serverError));
    }
  }
}
