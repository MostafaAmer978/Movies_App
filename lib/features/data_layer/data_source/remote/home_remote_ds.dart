import 'package:movies_app/features/data_layer/models/movie_details_model.dart';
import 'package:movies_app/features/data_layer/models/new_releases_model.dart';
import 'package:movies_app/features/data_layer/models/popular_model.dart';
import 'package:movies_app/features/data_layer/models/recommended_model.dart';
import 'package:movies_app/features/data_layer/models/similar_model.dart';

abstract class HomeRemoteDS {
  Future<PopularModel> getPopularMovies(int popularPage);

  Future<NewReleasesModel> getNewReleasesMovies(int newReleasesPage);

  Future<RecommendedModel> getRecommendedMovies(int recommendedPage);

  Future<MovieDetailsModel> getMovieDetails(String movieId);

  Future<SimilarModel> getSimilarMovies(String movieId, int similarPage);
}
