import 'package:medical_valley/features/home/home_search_screen/data/api/categories_client.dart';
import 'package:medical_valley/features/home/home_search_screen/data/api/services_client.dart';
import 'package:medical_valley/features/home/home_search_screen/data/models/categories_model.dart';
import 'package:medical_valley/features/home/home_search_screen/data/models/services_model.dart';

class GetCategoriesUseCase {
  CategoriesClient client ;
  ServicesClient servicesClient ;

  GetCategoriesUseCase(this.client,this.servicesClient);

  Future<CategoryResponse> getCategories ()async{

  var result = await client.getCategories();
  CategoryResponse category = CategoryResponse.fromJson(result);
  return category;
  }
  Future<ServicesResponse> getServices (int categoryId , int pageNumber , int pageSize)async{

  var result = await servicesClient.getServices(categoryId, pageNumber, pageSize);
  ServicesResponse services = ServicesResponse.fromJson(result);
  return services;
  }

}