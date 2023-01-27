import 'package:get_it/get_it.dart';
import 'package:medical_valley/features/home/history/data/get_clinic_repo.dart';
import 'package:medical_valley/features/home/history/data/source/json_data.dart';
import 'package:medical_valley/features/home/history/domain/get_clinic_usecase.dart';
import 'package:medical_valley/features/home/history/presentation/bloc/clinics_bloc.dart';
final getIt = GetIt.instance;

configureDependencies (){
  getIt.registerFactory(() => ClinicsBloc(GetClinicUseCaseImpl(GetClinicRepoImpl(JsonDataSrc()))));
}