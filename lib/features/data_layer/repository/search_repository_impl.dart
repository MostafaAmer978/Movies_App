import 'package:movies_app/features/data_layer/data_source/remote/search_remote_ds.dart';
import 'package:movies_app/features/data_layer/models/search_model.dart';
import 'package:movies_app/features/domain_layer/repository/search_repository.dart';

class SearchRepositoryImpl implements SearchRepository {
  SearchRemoteDS searchRemoteDS;

  SearchRepositoryImpl({required this.searchRemoteDS});

  @override
  Future<SearchModel> getSearch(String searchMovie,int searchPage) async {
    try {
      SearchModel searchModel =
          await searchRemoteDS.getSearchMovies(searchMovie,searchPage);
      return searchModel;
    } catch (e) {
      throw Exception("Error : ${e.toString()}");
    }
  }
}
