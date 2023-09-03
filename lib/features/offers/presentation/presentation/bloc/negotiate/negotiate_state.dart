abstract class NegotiateState {}

class NegotiateStateEmpty extends NegotiateState {}

class NegotiateStateSuccess extends NegotiateState {}

class NegotiateStateLoading extends NegotiateState {}

class NegotiateStateError extends NegotiateState {
  String error;

  NegotiateStateError(this.error);
}

class VerifyRequestStateSuccess extends NegotiateState {
  int id;

  VerifyRequestStateSuccess(this.id);
}

class VerifyRequestStateLoading extends NegotiateState {}

class VerifyRequestStateError extends NegotiateState {}
