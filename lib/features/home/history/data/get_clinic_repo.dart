import 'package:medical_valley/features/home/history/data/clinic_model.dart';
import 'package:medical_valley/features/home/history/data/source/json_data.dart';


abstract class GetClinicRepo {
  Future<Clinics> getAllClinics();
}

 class GetClinicRepoImpl extends GetClinicRepo {
  JsonDataSrc src ;

  GetClinicRepoImpl(this.src);

  @override
  Future<Clinics> getAllClinics() async{
    return await src.readJson();
  }

  @override
  Future<void> changePrice(double price) async{
    await src.changePrice(price);
  }
}

