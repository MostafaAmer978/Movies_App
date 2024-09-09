import 'package:movies_app/features/data_layer/models/category_model.dart';
import 'package:movies_app/features/data_layer/models/movie_list_genres_model.dart';

abstract class BrowseRemoteDS {
  Future<MovieListGenresModel> getMovieListGenres();

  Future<CategoryModel> getCategoryMovies(String categoryId,int categoryPage);
}
