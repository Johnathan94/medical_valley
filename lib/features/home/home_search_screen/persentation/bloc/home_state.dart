import 'package:medical_valley/core/base_service/network_error.dart';
import 'package:medical_valley/features/home/home_search_screen/data/models/categories_model.dart';

abstract class MyHomeState {}
 class SuccessHomeState extends MyHomeState {
 CategoryResponse category ;

 SuccessHomeState(this.category);
}
 class InitialHomeState extends MyHomeState {}
 class ErrorHomeState extends MyHomeState {
  ErrorStates states ;

  ErrorHomeState(this.states);
}
 class LoadingHomeState extends MyHomeState {}