import 'package:medical_valley/features/home/history/data/sortModel.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
class AppInitializer {
  static  List<SortModel> sortChoices = [];

   static void initializeAppWithContext(context) {
      sortChoices.addAll([
        SortModel(true, AppLocalizations.of(context)!.accepted_neo),
        SortModel(true, AppLocalizations.of(context)!.pending_nego),
        SortModel(true, AppLocalizations.of(context)!.most_recent),
        SortModel(true, AppLocalizations.of(context)!.oldest),
      ]);
    }

}