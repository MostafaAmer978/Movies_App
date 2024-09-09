import 'package:movies_app/features/data_layer/models/search_model.dart';
import 'package:movies_app/features/domain_layer/repository/search_repository.dart';

class SearchUseCase {
  SearchRepository searchRepository;

  SearchUseCase({required this.searchRepository});

  Future<SearchModel> getSearch(String searchMovie,int searchPage) => searchRepository.getSearch(searchMovie,searchPage);
}
