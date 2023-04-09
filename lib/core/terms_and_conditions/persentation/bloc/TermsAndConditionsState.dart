import '../../data/terms_and_conditions_model.dart';

abstract class TermsAndConditionsState {}
class InitialTermsAndConditionsState extends TermsAndConditionsState{}
class SuccessTermsAndConditionsState extends TermsAndConditionsState{
  TermsAndConditionsModel termsAndConditionsModel;
  SuccessTermsAndConditionsState(this.termsAndConditionsModel);
}
class ErrorTermsAndConditionsState extends TermsAndConditionsState{}
class LoadingTermsAndConditionsState extends TermsAndConditionsState{}