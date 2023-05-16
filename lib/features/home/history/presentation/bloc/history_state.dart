import 'package:medical_valley/features/home/history/data/negotiations/negotiations_model.dart';
import 'package:medical_valley/features/home/history/data/requests/requests_model.dart';
import 'package:medical_valley/features/home/history/data/reservations/reservations_model.dart';

class HistoryState {
  UserRequestsResponseModel? requests;
  ReservationsResponse? reservations;
  NegotiationsResponse? negotiations;
  ActionStates states;
  HistoryState(
    this.states, {
    this.requests,
    this.reservations,
    this.negotiations,
  });
}

enum ActionStates { idle, loading, success, error }
