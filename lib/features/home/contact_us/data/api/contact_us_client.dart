
import 'package:dio/dio.dart';
import 'package:medical_valley/features/home/contact_us/data/model/contact_us_response_model.dart';
class ContactUsClient{
  Dio dio ;

  ContactUsClient(this.dio);

  contactUs(ContactUsModel contactUsModel)async{
    Response response =  await dio.post("${dio.options.baseUrl}/Misc/ContactUs",data: contactUsModel.toJson());
    return response.data;
  }

}