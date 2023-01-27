import 'package:medical_valley/features/home/history/data/clinic_model.dart';
import 'package:medical_valley/features/home/history/data/get_clinic_repo.dart';

abstract class GetClinicUseCase {
 Future<Clinics> getAllClinics();
}

class GetClinicUseCaseImpl extends GetClinicUseCase{
  GetClinicRepo getClinicRepo ;

  GetClinicUseCaseImpl( this.getClinicRepo);

  @override
  Future<Clinics> getAllClinics() async{
    return await getClinicRepo.getAllClinics();
  }



}