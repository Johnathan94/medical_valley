import 'package:medical_valley/features/home/history/data/clinic_model.dart';
import 'package:medical_valley/features/home/history/data/get_negotiations_api.dart';

abstract class GetHistoryUseCase {
 Future<Clinics> getAllHistoryNegotiations(int page , int pageSize);
}

class GetHistoryUseCaseImpl extends GetHistoryUseCase{
  HistoryClient historyClient ;

  GetHistoryUseCaseImpl( this.historyClient);

  @override
  Future<Clinics> getAllHistoryNegotiations(int page , int pageSize) async{
    return await historyClient.getHistoryNegotiations(page, pageSize);
  }



}