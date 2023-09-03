import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/update_fcm_use_case.dart';
import 'fcm_state.dart';

class FcmBloc extends Cubit<FcmState> {
  UpdateFcmUseCase updateFcmUseCase;
  FcmBloc(this.updateFcmUseCase) : super(FcmState());

  void updateFcmToken() {
    updateFcmUseCase.updateFcmToken();
  }
}
