import 'package:movies_app/features/data_layer/data_source/remote/browse_remote_ds.dart';
import 'package:movies_app/features/data_layer/models/category_model.dart';
import 'package:movies_app/features/data_layer/models/movie_list_genres_model.dart';
import 'package:movies_app/features/domain_layer/repository/browse_repository.dart';

class BrowseRepositoryImpl implements BrowseRepository {
  BrowseRemoteDS browseRemoteDS;

  BrowseRepositoryImpl({required this.browseRemoteDS});

  @override
  Future<MovieListGenresModel> getBrowseMovies() async {
    MovieListGenresModel movieListGenresModel =
        await browseRemoteDS.getMovieListGenres();
    return movieListGenresModel;
  }

  @override
  Future<CategoryModel> getCategoryMovies(String categoryId,int categoryPage) async {
    CategoryModel browseCategoryModel =
        await browseRemoteDS.getCategoryMovies(categoryId,categoryPage);
    return browseCategoryModel;
  }
}
