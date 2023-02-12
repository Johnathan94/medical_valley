import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../result_status.dart';
import 'language_event.dart';
import 'language_state.dart';

class LanguageBloc extends Bloc<LanguageEvent, LanguageState> {
  /// {@macro counter_bloc}
  LanguageBloc() : super(LanguageState(ResultStatus.empty));

  Stream<LanguageState> mapEventToState(LanguageEvent event) async* {
    yield LanguageState(ResultStatus.success, locale: event.locale);
  }
}
