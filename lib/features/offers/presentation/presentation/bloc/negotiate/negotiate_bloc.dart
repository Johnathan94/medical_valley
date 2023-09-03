import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medical_valley/features/offers/presentation/data/repo/negotiate_repo.dart';
import 'package:medical_valley/features/offers/presentation/presentation/bloc/negotiate/negotiate_state.dart';

class NegotiateBloc extends Cubit<NegotiateState> {
  NegotiateBloc(this.negotiateRepo) : super(NegotiateStateLoading());
  NegotiateRepo negotiateRepo;
  void negotiate(List<int>? offerIds) async {
    emit(NegotiateStateLoading());
    var offers = await negotiateRepo.negotiate(offerIds);
    offers.fold((l) {
      emit(NegotiateStateError(l.error ?? ""));
    }, (right) {
      emit(NegotiateStateSuccess());
    });
  }

  void verifyRequest(int id) async {
    emit(VerifyRequestStateLoading());
    var response = await negotiateRepo.verifyBook(id);
    response.fold((l) {
      emit(VerifyRequestStateError());
    }, (right) {
      emit(VerifyRequestStateSuccess(id));
    });
  }
}
