import 'package:movies_app/features/data_layer/models/category_model.dart';
import 'package:movies_app/features/data_layer/models/movie_list_genres_model.dart';

abstract class BrowseRepository {
  Future<MovieListGenresModel> getBrowseMovies();

  Future<CategoryModel> getCategoryMovies(String categoryId,int categoryPage);
}
