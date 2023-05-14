import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medical_valley/features/home/history/data/requests/requests_model.dart';
import 'package:medical_valley/features/home/history/data/reservations/reservations_model.dart';
import 'package:medical_valley/features/home/history/domain/get_requests_usecase.dart';
import 'package:medical_valley/features/home/history/domain/get_reservations_usecase.dart';
import 'package:medical_valley/features/home/history/presentation/bloc/history_state.dart';
class HistoryBloc extends Cubit<HistoryState>{
  GetRequestsUseCase requestsUseCase ;
  GetReservationsUseCase reservationsUseCase ;
  HistoryBloc(
      this.requestsUseCase,
      this.reservationsUseCase,
      ):super(HistoryState(ActionStates.idle));
  getUserRequests (int page , int pageSize)async{
    emit(HistoryState(ActionStates.loading));
    try
    {
      UserRequestsResponseModel clinics = await requestsUseCase.getUserRequests(page,pageSize);
      emit(HistoryState(ActionStates.success, requests: clinics));
    }       catch(e){
      emit(HistoryState(ActionStates.error));
    }
  }
  getReservations (int page , int pageSize)async{
    emit(HistoryState(ActionStates.loading));
    try
    {
      ReservationsResponse response = await reservationsUseCase.getReservations(page,pageSize);
      emit(HistoryState(ActionStates.success, reservations: response));
    }       catch(e){
      emit(HistoryState(ActionStates.error));
    }
  }

}