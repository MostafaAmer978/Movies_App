import 'package:movies_app/features/data_layer/models/movie_details_model.dart';
import 'package:movies_app/features/data_layer/models/new_releases_model.dart';
import 'package:movies_app/features/data_layer/models/popular_model.dart';
import 'package:movies_app/features/data_layer/models/recommended_model.dart';

abstract class HomeLocalDS {
  Future<PopularModel> getPopularMovies();

  Future<NewReleasesModel> getNewReleasesMovies();

  Future<RecommendedModel> getRecommendedMovies();

  Future<MovieDetailsModel> getMovieDetails();
}
