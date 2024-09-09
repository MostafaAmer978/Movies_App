import 'package:movies_app/features/data_layer/models/search_model.dart';

abstract class SearchRemoteDS {
  Future<SearchModel> getSearchMovies(String searchMovie,int searchPage);
}
