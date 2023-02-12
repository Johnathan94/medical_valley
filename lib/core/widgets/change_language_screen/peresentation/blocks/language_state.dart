import 'package:flutter/material.dart';

import '../../../../result_status.dart';

class LanguageState {
  Locale? locale;
  ResultStatus status;
  List<Object> get props => [locale!];

  LanguageState(
    this.status, {
    this.locale,
  });
}
