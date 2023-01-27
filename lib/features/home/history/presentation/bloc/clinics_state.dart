import 'package:medical_valley/features/home/history/data/clinic_model.dart';

class ClinicsState {
  Clinics? clinics ;
  ActionStates states ;
  ClinicsState(this.states ,{this.clinics });
}
enum ActionStates {
  idle ,loading , success , error
}