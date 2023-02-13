import 'package:medical_valley/features/home/home_search_screen/data/api/search_client.dart';
import 'package:medical_valley/features/home/home_search_screen/data/models/search_result.dart';

class SearchWithKeyboard {
  SearchClient client ;

  SearchWithKeyboard(this.client);

  searchWithKeyword(String keyword , int page , int pageSize)async{
   var result = await client.searchWithKeyword(keyword, page, pageSize);
    return SearchResult.fromJson(result);
  }
}