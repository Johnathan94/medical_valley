abstract class LoginState {}
 class LoginStateEmpty extends LoginState{}
 class LoginStateSuccess extends LoginState{
 String mobile ;
 LoginStateSuccess(this.mobile);
}
 class LoginStateLoading extends LoginState{}
 class LoginStateError extends LoginState{}
