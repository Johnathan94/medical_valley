import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:medical_valley/features/home/history/data/requests/requests_model.dart';
import 'package:medical_valley/features/home/history/data/reservations/reservations_model.dart';
import 'package:medical_valley/features/home/history/domain/get_negotiations_usecase.dart';
import 'package:medical_valley/features/home/history/domain/get_requests_usecase.dart';
import 'package:medical_valley/features/home/history/domain/get_reservations_usecase.dart';
import 'package:medical_valley/features/home/history/presentation/bloc/history_state.dart';

class HistoryBloc extends Cubit<HistoryState> {
  GetRequestsUseCase requestsUseCase;
  GetReservationsUseCase reservationsUseCase;
  GetNegotiationsUseCase negotiationsUseCase;
  List<HistoryItem> allResults = [];

  HistoryBloc(
    this.requestsUseCase,
    this.reservationsUseCase,
    this.negotiationsUseCase,
  ) : super(HistoryState(ActionStates.idle));
  getUserRequests(int page, int pageSize) async {
    emit(HistoryState(ActionStates.loading));
    try {
      UserRequestsResponseModel clinics =
          await requestsUseCase.getUserRequests(page, pageSize);
      allResults.addAll(clinics.data!.results!);
      emit(HistoryState(ActionStates.success, requests: clinics));
    } catch (e) {
      emit(HistoryState(ActionStates.error));
    }
  }

  getReservations(int page, int pageSize) async {
    emit(HistoryState(ActionStates.loading));
    try {
      ReservationsResponse response =
          await reservationsUseCase.getReservations(page, pageSize);
      emit(HistoryState(ActionStates.success, reservations: response));
    } catch (e) {
      emit(HistoryState(ActionStates.error));
    }
  }

  getNegotiations(int page, int pageSize) async {
    emit(HistoryState(ActionStates.loading));
    try {
      var response = await negotiationsUseCase.getNegotiations(page, pageSize);
      response.fold((l) => emit(HistoryState(ActionStates.error)),
          (r) => emit(HistoryState(ActionStates.success, negotiations: r)));
    } catch (e) {
      emit(HistoryState(ActionStates.error));
    }
  }

  String datePattern = "yyyy-dd-MM";
  String oldDate = "1000-01-01";
  filter(int filterType) {
    if (allResults.isNotEmpty) {
      switch (filterType) {
        case 1:
          allResults.sort((element, element2) {
            DateTime first = DateFormat(datePattern)
                .parse(element.appointmentDate ?? oldDate);
            DateTime second = DateFormat(datePattern)
                .parse(element2.appointmentDate ?? oldDate);
            return first.isAfter(second) ? 1 : -1;
          });
          break;
        case 0:
          allResults.sort((element, element2) {
            DateTime first = DateFormat(datePattern)
                .parse(element.appointmentDate ?? oldDate);
            DateTime second = DateFormat(datePattern)
                .parse(element2.appointmentDate ?? oldDate);
            return first.isBefore(second) ? 1 : -1;
          });
          break;
      }
      state.requests!.data!.results = allResults;
      emit(HistoryState(ActionStates.filter, requests: state.requests));
    } else {
      emit(HistoryState(ActionStates.error));
    }
  }
}
