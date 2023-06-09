import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medical_valley/features/offers/presentation/data/repo/offers_repo.dart';
import 'package:medical_valley/features/offers/presentation/presentation/bloc/offers_state.dart';

class OffersBloc extends Cubit<OffersState> {
  OffersBloc(this.offersRepo) : super(OffersStateEmpty());
  OffersRepo offersRepo;
  void getOffers(OffersEvent event) async {
    emit(OffersStateLoading());
    var offers =
        await offersRepo.getOffers(event.page, event.pageSize, event.requestId);
    offers.fold((l) {
      emit(OffersStateError(l.error ?? ""));
    }, (right) {
      emit(OffersStateSuccess(right));
    });
  }
}

class OffersEvent {
  final int page, pageSize, requestId;
  OffersEvent(this.page, this.pageSize, this.requestId);
}
