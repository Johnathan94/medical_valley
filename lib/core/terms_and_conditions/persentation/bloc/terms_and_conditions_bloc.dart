import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/terms_and_conditions_repo.dart';
import 'TermsAndConditionsState.dart';

class TermsAndConditionsBloc extends Cubit<TermsAndConditionsState>{

  TermsAndConditionsBloc(this.termsAndConditionsRepo) : super(InitialTermsAndConditionsState());
  TermsAndConditionsRepo termsAndConditionsRepo ;

  getTermsAndConditions ()async{
    emit(LoadingTermsAndConditionsState());
    var termsAndConditions = await termsAndConditionsRepo.getTermsAndCondition();
    termsAndConditions.fold(
            (l) {
          emit(ErrorTermsAndConditionsState());
        }, (r) {
      emit(SuccessTermsAndConditionsState(r));
    }
    );
  }
}