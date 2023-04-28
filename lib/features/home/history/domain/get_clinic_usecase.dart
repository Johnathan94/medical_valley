import 'package:medical_valley/features/home/history/data/clinic_model.dart';
import 'package:medical_valley/features/home/history/data/get_negotiations_api.dart';

abstract class GetHistoryUseCase {
 Future<NegotiationsHistoryModel> getAllHistoryNegotiations(int page , int pageSize);
}

class GetHistoryUseCaseImpl extends GetHistoryUseCase{
  HistoryClient historyClient ;

  GetHistoryUseCaseImpl( this.historyClient);

  @override
  Future<NegotiationsHistoryModel> getAllHistoryNegotiations(int page , int pageSize) async{
  var date = await historyClient.getHistoryNegotiations(page, pageSize);
 return NegotiationsHistoryModel.fromJson(date);
  }



}