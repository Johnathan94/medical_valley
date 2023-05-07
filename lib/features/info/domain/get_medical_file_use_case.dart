import 'package:dartz/dartz.dart';
import 'package:medical_valley/core/failures/failures.dart';
import 'package:medical_valley/features/info/data/medical_file_api.dart';
import 'package:medical_valley/features/info/data/medical_file_response.dart';

abstract class GetMedicalFileUseCase {
  Future<Either<Failure, MedicalFileModel>> getMedicalFile();
}

class GetMedicalFileUseCaseImpl extends GetMedicalFileUseCase {
  MedicalFileClient medicalFileClient;

  GetMedicalFileUseCaseImpl(this.medicalFileClient);

  @override
  Future<Either<Failure, MedicalFileModel>> getMedicalFile() async {
    try {
      var result = await medicalFileClient.getMedicalFile();
      var medicalFile = MedicalFileResponse.fromJson(result);
      if (medicalFile.responseCode! >= 200 && medicalFile.responseCode! < 300) {

        return  Right(medicalFile.data!);
      }
      return Left(ServerFailure());
    } catch (e) {
      return Left(ServerFailure());
    }
  }
}
