import 'package:dartz/dartz.dart';
import 'package:medical_valley/core/failures/failures.dart';
import 'package:medical_valley/features/info/data/medical_file_api.dart';
import 'package:medical_valley/features/info/data/medical_file_request.dart';
import 'package:medical_valley/features/info/data/medical_file_response.dart';

abstract class SetMedicalFileUseCase {
  Future<Either<ServerFailure, Unit>> setMedicalFile(MedicalFileRequest request);
}

class SetMedicalFileUseCaseImpl extends SetMedicalFileUseCase {
  MedicalFileClient medicalFileClient;

  SetMedicalFileUseCaseImpl(this.medicalFileClient);

  @override
  Future<Either<ServerFailure, Unit>> setMedicalFile(MedicalFileRequest request ) async {
    try {
      var result = await medicalFileClient.setMedicalFile(request);
      var medicalFile = MedicalFileResponse.fromJson(result);
      if (medicalFile.responseCode! >= 200 && medicalFile.responseCode! < 300) {
        return const Right(unit);
      }
      return Left(ServerFailure(error: medicalFile.message));
    } catch (e) {
      return Left(ServerFailure(error: e.toString()));
    }
  }
}
