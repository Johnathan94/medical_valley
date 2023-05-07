import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medical_valley/features/info/data/medical_file_request.dart';
import 'package:medical_valley/features/info/data/medical_file_response.dart';
import 'package:medical_valley/features/info/domain/get_medical_file_use_case.dart';
import 'package:medical_valley/features/info/domain/set_medical_file_use_case.dart';

class MedicalFileBloc extends Cubit<MedicalInfoState>{
  final GetMedicalFileUseCase useCase ;
  SetMedicalFileUseCase setUseCase ;
  MedicalFileBloc(this.useCase,this.setUseCase):super(MedicalInfoStateIdle());
     getMedicalFile()async{
       emit(MedicalInfoStateLoading());
       var either = await useCase.getMedicalFile();
       either.fold(
               (l) {
             emit(MedicalInfoStateError());
           }, (r) {
         emit(MedicalInfoStateSuccess(r));
       });

      }
      setMedicalFile(MedicalFileRequest model)async{
        emit(SetMedicalInfoStateLoading());
        var either = await setUseCase.setMedicalFile(model);
        either.fold(
                (l) {
              emit(SetMedicalInfoStateError(l.error ?? ""));
            }, (r) {
          emit(SetMedicalInfoStateSuccess());
        });      }

  }
abstract class MedicalInfoState {}
 class MedicalInfoStateLoading extends MedicalInfoState {}
 class MedicalInfoStateIdle extends MedicalInfoState {}
 class MedicalInfoStateSuccess extends MedicalInfoState {
  MedicalFileModel model ;

  MedicalInfoStateSuccess(this.model);
}
 class MedicalInfoStateError extends MedicalInfoState {}

class SetMedicalInfoStateLoading extends MedicalInfoState {}
 class SetMedicalInfoStateIdle extends MedicalInfoState {}
 class SetMedicalInfoStateSuccess extends MedicalInfoState {
   SetMedicalInfoStateSuccess();
}
 class SetMedicalInfoStateError extends MedicalInfoState {
  String error ;

  SetMedicalInfoStateError(this.error);
}