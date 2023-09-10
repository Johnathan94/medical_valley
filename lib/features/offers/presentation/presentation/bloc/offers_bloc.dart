import 'package:collection/collection.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medical_valley/features/home/history/data/negotiations/negotiations_model.dart';
import 'package:medical_valley/features/offers/presentation/data/model/offers_response.dart';
import 'package:medical_valley/features/offers/presentation/data/repo/offers_repo.dart';
import 'package:medical_valley/features/offers/presentation/presentation/bloc/offers_state.dart';
import 'package:medical_valley/features/offers/presentation/presentation/offer_ui_response.dart';

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
      emit(OffersStateSuccess(_filterOffers(right)));
    });
  }

  List<OfferUiResponseModel> _filterOffers(OffersResponse response) {
    List<OfferUiResponseModel> result = [];
    final groupedItems = groupBy(
        response.data!.results!, (NegotiationModel item) => item.requestId);
    final Map<int, List<NegotiationModel>> groupedItemsMap =
        Map.from(groupedItems);
    groupedItemsMap.forEach((key, value) {
      OfferUiResponseModel model = OfferUiResponseModel();
      model.latestOffer = value.first;
      model.offers = value;
      result.add(model);
    });
    return result;
  }
}

class OffersEvent {
  final int page, pageSize, requestId;
  OffersEvent(this.page, this.pageSize, this.requestId);
}
