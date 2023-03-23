import 'package:medical_valley/core/base_service/network_error.dart';
import 'package:medical_valley/features/home/home_search_screen/data/models/categories_model.dart';
import 'package:medical_valley/features/home/home_search_screen/data/models/search_result.dart';
import 'package:medical_valley/features/home/home_search_screen/data/models/services_model.dart';

abstract class MyHomeState {}
 class SuccessHomeState extends MyHomeState {
 CategoryResponse category ;

 SuccessHomeState(this.category);
}
 class SearchResultState extends MyHomeState {
 SearchResult searchResult ;

 SearchResultState(this.searchResult);
}
 class InitialHomeState extends MyHomeState {}
 class ErrorHomeState extends MyHomeState {
  ErrorStates states ;

  ErrorHomeState(this.states);
}
 class LoadingHomeState extends MyHomeState {}

 class LoadingServicesState extends MyHomeState {}
 class ErrorServicesState extends MyHomeState {
  ErrorStates states ;

  ErrorServicesState(this.states);
}
 class SuccessServicesState extends MyHomeState {
  ServicesResponse response ;

  SuccessServicesState(this.response);
}