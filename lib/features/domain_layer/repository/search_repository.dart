import 'package:movies_app/features/data_layer/models/search_model.dart';

abstract class SearchRepository {
  Future<SearchModel> getSearch(String searchMovie,int searchPage);
}
