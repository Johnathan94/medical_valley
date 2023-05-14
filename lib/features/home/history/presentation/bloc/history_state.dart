
import 'package:medical_valley/features/home/history/data/requests/requests_model.dart';
import 'package:medical_valley/features/home/history/data/reservations/reservations_model.dart';

class HistoryState {
  UserRequestsResponseModel? requests ;
  ReservationsResponse? reservations ;
  ActionStates states ;
  HistoryState(this.states ,{
    this.requests ,
    this.reservations ,
  });
}
enum ActionStates {
  idle ,loading , success , error
}