import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medical_valley/features/auth/login/data/repo/login_repo.dart';
import 'package:medical_valley/features/auth/login/presentation/bloc/loginState_state.dart';

class LoginBloc extends Cubit<LoginState >{
  LoginBloc(this.loginRepo): super(LoginStateEmpty());
  LoginRepo loginRepo ;
  void loginUser (LoginEvent event )async{
    emit(LoginStateLoading());
    var loginUser = await loginRepo.login(event.mobilePhone);
    loginUser.fold(
            (l) {
          emit(LoginStateError());
        }, (r) {
      emit(LoginStateSuccess(r));
    }
    );
  }


}
class LoginEvent{
  String mobilePhone ;

  LoginEvent(this.mobilePhone);
}