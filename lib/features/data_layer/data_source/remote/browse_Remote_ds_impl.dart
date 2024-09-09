import 'package:dio/dio.dart';
import 'package:movies_app/core/api/api_manager.dart';
import 'package:movies_app/core/api/end_point.dart';
import 'package:movies_app/features/data_layer/data_source/remote/browse_remote_ds.dart';
import 'package:movies_app/features/data_layer/models/category_model.dart';
import 'package:movies_app/features/data_layer/models/movie_list_genres_model.dart';

class BrowseRemoteDSImpl implements BrowseRemoteDS {
  @override
  Future<MovieListGenresModel> getMovieListGenres() async {
    ApiManager apiManager = ApiManager();
    try {
      var response = await apiManager.getData(EndPoints.movieList);
      MovieListGenresModel movieListGenresModel =
          MovieListGenresModel.fromJson(response.data);
      return movieListGenresModel;
    } catch (e) {
      throw Exception("Error : ${e.toString()}");
    }
  }

  @override
  Future<CategoryModel> getCategoryMovies(String categoryId,int categoryPage) async {
    try {
      ApiManager apiManager = ApiManager();
      Response response =
          await apiManager.getData(EndPoints.category, parameter: {
        "with_genres": categoryId,
        "page": categoryPage,
      });
      CategoryModel browseCategoryModel =
          CategoryModel.fromJson(response.data);
      return browseCategoryModel;
    } catch (e) {
      throw Exception("Error : ${e.toString()}");
    }
  }
}
