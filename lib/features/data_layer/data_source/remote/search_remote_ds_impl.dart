import 'package:dio/dio.dart';
import 'package:movies_app/core/api/api_manager.dart';
import 'package:movies_app/core/api/end_point.dart';
import 'package:movies_app/features/data_layer/data_source/remote/search_remote_ds.dart';
import 'package:movies_app/features/data_layer/models/search_model.dart';

class SearchRemoteDsImpl implements SearchRemoteDS {
  @override
  Future<SearchModel> getSearchMovies(searchMovie,searchPage) async {
    try {
      ApiManager apiManager = ApiManager();
      Response response =
          await apiManager.getData(EndPoints.searchMovies, parameter: {
        "query": searchMovie,
        "page": searchPage,
      });
      SearchModel searchModel = SearchModel.fromJson(response.data);
      return searchModel;
    } catch (e) {
      throw Exception("Error : ${e.toString()}");
    }
  }
}
