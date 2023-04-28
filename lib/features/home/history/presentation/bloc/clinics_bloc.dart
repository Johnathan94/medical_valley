import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medical_valley/features/home/history/data/clinic_model.dart';
import 'package:medical_valley/features/home/history/domain/get_clinic_usecase.dart';
import 'package:medical_valley/features/home/history/presentation/bloc/clinics_state.dart';
class HistoryBloc extends Cubit<HistoryState>{
  GetHistoryUseCase clinicUseCase ;
  HistoryBloc(this.clinicUseCase):super(HistoryState(ActionStates.idle));
  getAllHistoryNegotiations (int page , int pageSize)async{
    emit(HistoryState(ActionStates.loading));
    try
    {
      NegotiationsHistoryModel clinics = await clinicUseCase.getAllHistoryNegotiations(page,pageSize);
      emit(HistoryState(ActionStates.success, history: clinics));
    }       catch(e){
      emit(HistoryState(ActionStates.error));
    }
  }

}