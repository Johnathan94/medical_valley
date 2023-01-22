import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:medical_valley/features/home/widgets/home_base_stateful_widget.dart';

import '../../../widgets/home_base_app_bar.dart';

class HomeScreen extends HomeBaseStatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => HomeState();
}

class HomeState extends HomeBaseStatefulWidgetState {
  @override
  getBody() {
    return Container();
  }

  @override
  buildAppBar() {
    return CustomHomeAppBar(
      isSearchableAppBar: true,
      searchHint: AppLocalizations.of(context)!.search,
      goodMorningText: AppLocalizations.of(context)!.good_morning,
    );
  }
}
