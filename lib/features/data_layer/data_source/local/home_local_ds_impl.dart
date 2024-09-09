import 'package:movies_app/features/data_layer/data_source/local/home_local_ds.dart';
import 'package:movies_app/features/data_layer/models/movie_details_model.dart';
import 'package:movies_app/features/data_layer/models/new_releases_model.dart';
import 'package:movies_app/features/data_layer/models/popular_model.dart';
import 'package:movies_app/features/data_layer/models/recommended_model.dart';

class HomeLocalDSImpl implements HomeLocalDS {
  @override
  Future<PopularModel> getPopularMovies() {
    // TODO: implement getPopularMovies
    throw UnimplementedError();
  }

  @override
  Future<NewReleasesModel> getNewReleasesMovies() {
    // TODO: implement getNewReleasesMovies
    throw UnimplementedError();
  }

  @override
  Future<RecommendedModel> getRecommendedMovies() {
    // TODO: implement getRecommendedMovies
    throw UnimplementedError();
  }

  @override
  Future<MovieDetailsModel> getMovieDetails() {
    // TODO: implement getMovieDetails
    throw UnimplementedError();
  }
}
