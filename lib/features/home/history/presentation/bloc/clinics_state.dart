import 'package:medical_valley/features/home/history/data/clinic_model.dart';

class HistoryState {
  NegotiationsHistoryModel? history ;
  ActionStates states ;
  HistoryState(this.states ,{this.history });
}
enum ActionStates {
  idle ,loading , success , error
}