import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medical_valley/features/offers/presentation/data/repo/offers_repo.dart';
import 'package:medical_valley/features/offers/presentation/presentation/bloc/offers_state.dart';

class OffersBloc extends Cubit<OffersState >{
  OffersBloc(this.offersRepo): super(OffersStateEmpty());
  OffersRepo offersRepo ;
  void getOffers (OffersEvent event )async{
    emit(OffersStateLoading());
    var loginUser = await offersRepo.getOffers(event.page , event.pageSize, event.serviceId , event.categoryId);
    loginUser.fold(
            (l) {
          emit(OffersStateError());
        }, (r) {
      emit(OffersStateSuccess());
    }
    );
  }


}
class OffersEvent{
  final int page ,  pageSize ,  serviceId ,  categoryId;
  OffersEvent(this. page , this. pageSize , this. serviceId , this.categoryId);
}