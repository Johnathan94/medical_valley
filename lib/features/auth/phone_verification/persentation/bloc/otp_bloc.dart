import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medical_valley/features/auth/phone_verification/domain/verify_otp_use_case.dart';

class OtpBloc extends Cubit<OtpState>{
  VerifyOtpUseCase verifyOtpUseCase ;

  OtpBloc(this.verifyOtpUseCase):super(IdleOtpState());

  Future verifyOtp (String otp,String mobile)async{
    emit(LoadingOtpState());
    var either = await verifyOtpUseCase.verifyOtp(otp, mobile);
    either.fold(
            (l) {
          emit(ErrorOtpState());
        }, (r) {
      emit(SuccessOtpState());
    });
  }

}
abstract class OtpState {}
 class LoadingOtpState extends OtpState {}
 class SuccessOtpState extends OtpState {}
 class ErrorOtpState extends OtpState {}
 class IdleOtpState extends OtpState {}