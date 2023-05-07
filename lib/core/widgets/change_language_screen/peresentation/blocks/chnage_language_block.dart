import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'language_state.dart';

class LanguageBloc extends Cubit<LanguageState> {
  LanguageBloc() : super( LanguageState()){
  }

  changeLanguage(Locale locale)   {
    emit(LanguageState(locale: locale));
  }
}
