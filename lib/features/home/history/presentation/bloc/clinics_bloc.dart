import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medical_valley/features/home/history/data/clinic_model.dart';
import 'package:medical_valley/features/home/history/domain/get_clinic_usecase.dart';
import 'package:medical_valley/features/home/history/presentation/bloc/clinics_state.dart';
class HistoryBloc extends Cubit<ClinicsState>{
  GetHistoryUseCase clinicUseCase ;
  HistoryBloc(this.clinicUseCase):super(ClinicsState(ActionStates.idle));
  getAllHistoryNegotiations (int page , int pageSize)async{
    emit(ClinicsState(ActionStates.loading));
    try
    {
      Clinics clinics = await clinicUseCase.getAllHistoryNegotiations(page,pageSize);
      emit(ClinicsState(ActionStates.success, clinics: clinics));
    }       catch(e){
      emit(ClinicsState(ActionStates.error));
    }
  }

}