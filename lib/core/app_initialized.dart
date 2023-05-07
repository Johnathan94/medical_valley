import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:medical_valley/core/strings/images.dart';
import 'package:medical_valley/core/widgets/change_language_screen/data/models/language_model.dart';
import 'package:medical_valley/features/home/history/data/sortModel.dart';
import 'package:medical_valley/features/payment/data/payment_data.dart';

class AppInitializer {
  static List<SortModel> sortChoicesHistory = [];
  static List<SortModel> sortChoicesOffers = [];
  static List<String> optionsList = [];
  static List<PaymentData> paymentMethods = [];
  static List<LanguageModel> languages = [];

  static initializeAppWithContext(context) async {
    sortChoicesHistory.addAll([
      SortModel(true, AppLocalizations.of(context)!.accepted_neo),
      SortModel(true, AppLocalizations.of(context)!.pending_nego),
      SortModel(true, AppLocalizations.of(context)!.most_recent),
      SortModel(true, AppLocalizations.of(context)!.oldest),
    ]);
    optionsList.addAll([
      AppLocalizations.of(context)!.yes,
      AppLocalizations.of(context)!.no,
    ]);
    sortChoicesOffers.addAll([
      SortModel(true, AppLocalizations.of(context)!.highest_price),
      SortModel(true, AppLocalizations.of(context)!.lowest_price),
      SortModel(true, AppLocalizations.of(context)!.location),
      SortModel(true, AppLocalizations.of(context)!.time),
    ]);
    paymentMethods
        .add(PaymentData(1, AppLocalizations.of(context)!.visa, visaIcon));
    paymentMethods
        .add(PaymentData(2, AppLocalizations.of(context)!.paypal, paypalIcon));
    paymentMethods.add(PaymentData(
        3, AppLocalizations.of(context)!.google_pay, googlePayIcon));

    languages.add(LanguageModel(1, AppLocalizations.of(context)!.english_title,
        AppLocalizations.of(context)!.english_title, false));
    languages.add(LanguageModel(2, AppLocalizations.of(context)!.arabic_title,
        AppLocalizations.of(context)!.arabic_sub_title, false));
  }
}
