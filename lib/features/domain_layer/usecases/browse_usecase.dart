import 'package:movies_app/features/data_layer/models/category_model.dart';
import 'package:movies_app/features/data_layer/models/movie_list_genres_model.dart';
import 'package:movies_app/features/domain_layer/repository/browse_repository.dart';

class BrowseUseCase {
  BrowseRepository browseRepository;

  BrowseUseCase({required this.browseRepository});

  Future<MovieListGenresModel> getMovieListGenres() =>
      browseRepository.getBrowseMovies();

  Future<CategoryModel> getCategoryMovies(String categoryId,int categoryPage) =>
      browseRepository.getCategoryMovies(categoryId,categoryPage);
}
