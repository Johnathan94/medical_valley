import 'package:medical_valley/features/home/history/data/sortModel.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
class AppInitializer {
  static  List<SortModel> sortChoicesHistory = [];
  static  List<SortModel> sortChoicesOffers = [];

   static void initializeAppWithContext(context) {
      sortChoicesHistory.addAll([
        SortModel(true, AppLocalizations.of(context)!.accepted_neo),
        SortModel(true, AppLocalizations.of(context)!.pending_nego),
        SortModel(true, AppLocalizations.of(context)!.most_recent),
        SortModel(true, AppLocalizations.of(context)!.oldest),
      ]);
      sortChoicesOffers.addAll([
        SortModel(true, AppLocalizations.of(context)!.highest_price),
        SortModel(true, AppLocalizations.of(context)!.lowest_price),
        SortModel(true, AppLocalizations.of(context)!.location),
        SortModel(true, AppLocalizations.of(context)!.time),
      ]);
    }

}