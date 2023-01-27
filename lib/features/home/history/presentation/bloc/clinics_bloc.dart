import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medical_valley/features/home/history/data/clinic_model.dart';
import 'package:medical_valley/features/home/history/domain/get_clinic_usecase.dart';
import 'package:medical_valley/features/home/history/presentation/bloc/clinics_state.dart';
class ClinicsBloc extends Cubit<ClinicsState>{
  GetClinicUseCase clinicUseCase ;
  ClinicsBloc(this.clinicUseCase):super(ClinicsState(ActionStates.idle));
  getAllClinics ()async{
    emit(ClinicsState(ActionStates.loading));
    try
    {
      Clinics clinics = await clinicUseCase.getAllClinics();
      emit(ClinicsState(ActionStates.success, clinics: clinics));
    }       catch(e){
      emit(ClinicsState(ActionStates.error));
    }
  }

}