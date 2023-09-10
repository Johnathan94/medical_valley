import 'package:medical_valley/features/offers/presentation/presentation/offer_ui_response.dart';

abstract class OffersState {}

class OffersStateEmpty extends OffersState {}

class OffersStateSuccess extends OffersState {
  List<OfferUiResponseModel> offersResponse;
  OffersStateSuccess(this.offersResponse);
}

class OffersStateLoading extends OffersState {}

class OffersStateError extends OffersState {
  String err;

  OffersStateError(this.err);
}
