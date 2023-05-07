
import 'package:dio/dio.dart';
import 'package:medical_valley/core/shared_pref/shared_pref.dart';
import 'package:medical_valley/features/auth/phone_verification/data/model/otp_response_model.dart';
import 'package:medical_valley/features/info/data/medical_file_request.dart';
class MedicalFileClient{
  Dio dio ;

  MedicalFileClient(this.dio);

  getMedicalFile()async{
    var userDate = UserDate.fromJson(LocalStorageManager.getUser()!);
    Response response =  await dio.get("${dio.options.baseUrl}/User/GetMedicalFile?userId=${userDate.id}",);
    return response.data;
  }
  setMedicalFile(MedicalFileRequest request)async{
    Response response =  await dio.post("${dio.options.baseUrl}/User/MedicalFile",data: request.toJson());
    return response.data;
  }


}