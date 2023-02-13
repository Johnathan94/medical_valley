import 'package:get_it/get_it.dart';
import 'package:medical_valley/core/base_service/dio_manager.dart';
import 'package:medical_valley/features/auth/login/data/api_service/login_client.dart';
import 'package:medical_valley/features/auth/login/data/repo/login_repo.dart';
import 'package:medical_valley/features/auth/login/presentation/bloc/login_bloc.dart';
import 'package:medical_valley/features/auth/register/data/api_service/register_client.dart';
import 'package:medical_valley/features/auth/register/data/repo/register_repo.dart';
import 'package:medical_valley/features/auth/register/domain/register_usecase.dart';
import 'package:medical_valley/features/auth/register/presentation/register_bloc/register_bloc.dart';
import 'package:medical_valley/features/home/history/data/get_clinic_repo.dart';
import 'package:medical_valley/features/home/history/data/source/json_data.dart';
import 'package:medical_valley/features/home/history/domain/get_clinic_usecase.dart';
import 'package:medical_valley/features/home/history/presentation/bloc/clinics_bloc.dart';
import 'package:medical_valley/features/home/home_search_screen/data/api/categories_client.dart';
import 'package:medical_valley/features/home/home_search_screen/data/api/search_client.dart';
import 'package:medical_valley/features/home/home_search_screen/domain/get_categories_use_case.dart';
import 'package:medical_valley/features/home/home_search_screen/domain/search_with_keyword.dart';
import 'package:medical_valley/features/home/home_search_screen/persentation/bloc/home_bloc.dart';
final getIt = GetIt.instance;

configureDependencies (){
  getIt.registerFactory(() => ClinicsBloc(GetClinicUseCaseImpl(GetClinicRepoImpl(JsonDataSrc()))));
  getIt.registerFactory(() => RegisterBloc(RegisterUseCaseImpl(RegisterUserRepoImpl(RegisterClient(DioManager.getDio())))));
  getIt.registerFactory(() => LoginBloc(LoginRepoImpl(LoginClient(DioManager.getDio()))));
  getIt.registerFactory(() => HomeBloc(GetCategoriesUseCase(CategoriesClient(DioManager.getDio())),SearchWithKeyboard(SearchClient(DioManager.getDio()))));
}