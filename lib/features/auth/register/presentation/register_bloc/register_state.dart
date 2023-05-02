abstract class RegisterState {}
 class RegisterStateEmpty extends RegisterState{}
 class RegisterStateSuccess extends RegisterState{
  String? mobile ;

  RegisterStateSuccess(this.mobile);
 }
 class RegisterStateLoading extends RegisterState{}
 class RegisterStateError extends RegisterState{
 String? error ;

 RegisterStateError(this.error);
}
