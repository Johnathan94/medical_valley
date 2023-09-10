import 'package:medical_valley/features/home/history/data/negotiations/negotiations_model.dart';

class OfferUiResponseModel {
  late NegotiationModel latestOffer;
  late List<NegotiationModel> offers;
  bool isExpanded = false;

  OfferUiResponseModel();
}
