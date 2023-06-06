import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medical_valley/features/home/home_screen/data/book_request_model.dart';
import 'package:medical_valley/features/home/home_screen/data/repo/book_request_repo.dart';

class BookRequestBloc extends Cubit<BookRequestState> {
  BookRequestRepo requestRepo;

  BookRequestBloc(this.requestRepo)
      : super(BookRequestState(BookedState.ideal));

  sendRequest(BookRequestModel model) async {
    try {
      emit(BookRequestState(BookedState.loading));
      var either = await requestRepo.sendRequest(model);
      either.fold(
          (l) => emit(BookRequestState(BookedState.fail, error: l.error)),
          (r) => emit(BookRequestState(BookedState.success, requestId: r)));
    } catch (e) {
      emit(BookRequestState(BookedState.fail));
    }
  }
}

class BookRequestState {
  BookedState state;
  String? error;
  int? serviceId, categoryId, requestId;

  BookRequestState(this.state,
      {this.categoryId, this.serviceId, this.requestId, this.error});
}

enum BookedState { ideal, loading, success, fail }
