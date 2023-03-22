
abstract class NegotiateState {}
 class NegotiateStateEmpty extends NegotiateState{}
 class NegotiateStateSuccess extends NegotiateState{
}
 class NegotiateStateLoading extends NegotiateState{}
 class NegotiateStateError extends NegotiateState{}
 class VerifyRequestStateSuccess extends NegotiateState{
}
 class VerifyRequestStateLoading extends NegotiateState{}
 class VerifyRequestStateError extends NegotiateState{}
