import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medical_valley/features/offers/presentation/data/model/verifyModel/verify_model.dart';
import 'package:medical_valley/features/offers/presentation/data/repo/negotiate_repo.dart';
import 'package:medical_valley/features/offers/presentation/presentation/bloc/negotiate/negotiate_state.dart';

class NegotiateBloc extends Cubit<NegotiateState> {
  NegotiateBloc(this.negotiateRepo) : super(NegotiateStateLoading());
  NegotiateRepo negotiateRepo;
  void negotiate(List<int>? offerIds) async {
    emit(NegotiateStateLoading());
    var offers = await negotiateRepo.negotiate(offerIds);
    offers.fold((l) {
      emit(NegotiateStateError());
    }, (right) {
      emit(NegotiateStateSuccess());
    });
  }

  void verifyRequest(VerifyRequest request) async {
    emit(VerifyRequestStateLoading());
    var response = await negotiateRepo.verifyBook(request);
    response.fold((l) {
      emit(VerifyRequestStateError());
    }, (right) {
      emit(VerifyRequestStateSuccess());
    });
  }
}
