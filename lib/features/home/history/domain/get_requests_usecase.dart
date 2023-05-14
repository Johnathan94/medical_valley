import 'package:medical_valley/features/home/history/data/requests/requests_model.dart';
import 'package:medical_valley/features/home/history/data/requests/get_requets_api.dart';

abstract class GetRequestsUseCase {
 Future<UserRequestsResponseModel> getUserRequests(int page , int pageSize);
}

class GetRequestsUseCaseImpl extends GetRequestsUseCase{
  UserRequestsClient historyClient ;

  GetRequestsUseCaseImpl( this.historyClient);

  @override
  Future<UserRequestsResponseModel> getUserRequests(int page , int pageSize) async{
  var date = await historyClient.getUserRequests(page, pageSize);
 return UserRequestsResponseModel.fromJson(date);
  }



}