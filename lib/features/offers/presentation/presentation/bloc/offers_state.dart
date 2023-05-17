import 'package:medical_valley/features/offers/presentation/data/model/offers_response.dart';

abstract class OffersState {}

class OffersStateEmpty extends OffersState {}

class OffersStateSuccess extends OffersState {
  OffersResponse offersResponse;
  OffersStateSuccess(this.offersResponse);
}

class OffersStateLoading extends OffersState {}

class OffersStateError extends OffersState {
  String err;

  OffersStateError(this.err);
}
