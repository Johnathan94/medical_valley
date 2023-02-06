import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medical_valley/features/auth/register/data/model/register_request_model.dart';
import 'package:medical_valley/features/auth/register/domain/register_usecase.dart';
import 'package:medical_valley/features/auth/register/presentation/register_bloc/register_state.dart';

class RegisterBloc extends Cubit<RegisterState >{
  RegisterBloc(this.registerUseCase): super(RegisterStateEmpty());
RegisterUseCase registerUseCase ;
void registerUser (RegisterEvent event )async{
  emit(RegisterStateLoading());
  var registerUser = await registerUseCase.registerUser(event.model);
  registerUser.fold(
          (l) {
      emit(RegisterStateError());
  }, (r) {
    emit(RegisterStateSuccess());
  }
  );
}


}
class RegisterEvent{
  RegisterRequestModel model ;

  RegisterEvent(this.model);
}