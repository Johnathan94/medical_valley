
import 'package:dio/dio.dart';
import 'package:medical_valley/core/base_service/dio_manager.dart';
import 'package:medical_valley/features/home/home_screen/data/book_request_model.dart';
class BookRequestClient{
  Dio dio = DioManager.getDio();

  BookRequestClient();

  bookRequest (BookRequestModel requestModel)async{
    Response response =  await dio.post("${dio.options.baseUrl}/Provider/BookRequest",
    data: requestModel.toJson());
    return response.data;
  }

}