

import 'package:dio/dio.dart';
import 'package:medical_valley/core/shared_pref/shared_pref.dart';
import 'package:medical_valley/features/auth/phone_verification/data/model/otp_response_model.dart';

class NotificationClient {
  Dio dio ;

  NotificationClient(this.dio);

    getNotifications()async{
    UserDate user = UserDate.fromJson(LocalStorageManager.getUser()!);
    Response response =  await dio.get("${dio.options.baseUrl}/User/GetNotifications?userId=${user.id!}",);
    return response.data;
  }
}