
import 'package:dio/dio.dart';
import 'package:medical_valley/core/shared_pref/shared_pref.dart';
import 'package:medical_valley/features/auth/phone_verification/data/model/otp_response_model.dart';

class ReservationsClient{
  Dio dio ;

  ReservationsClient(this.dio);

  getReservations(int page , int pageSize ,{int? serviceId , int? categoryId })async{
    Response response;
    UserDate user = UserDate.fromJson(LocalStorageManager.getUser()!);
      response =  await dio.get("${dio.options.baseUrl}/Request/Reservations?PageNumber=$page&PageSize=$pageSize&UserId=${user.id!}",);
    return response.data;
  }

}