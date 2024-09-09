import 'package:movies_app/features/data_layer/data_source/remote/home_remote_ds.dart';
import 'package:movies_app/features/data_layer/models/movie_details_model.dart';
import 'package:movies_app/features/data_layer/models/new_releases_model.dart';
import 'package:movies_app/features/data_layer/models/popular_model.dart';
import 'package:movies_app/features/data_layer/models/recommended_model.dart';
import 'package:movies_app/features/data_layer/models/similar_model.dart';
import 'package:movies_app/features/domain_layer/repository/home_repository.dart';

class HomeRepositoryImpl implements HomeRepository {
  HomeRemoteDS homeRemoteDS;

  HomeRepositoryImpl({required this.homeRemoteDS});

  @override
  Future<PopularModel> getPopularMovies(int popularPage) async {
    try {
      PopularModel popularModel = await homeRemoteDS.getPopularMovies(popularPage);
      return popularModel;
    } catch (e) {
      throw Exception("Error : ${e.toString()}");
    }
  }

  @override
  Future<NewReleasesModel> getNewReleasesMovies(int newReleasesPage) async {
    try {
      NewReleasesModel newReleasesModel =
          await homeRemoteDS.getNewReleasesMovies(newReleasesPage);
      return newReleasesModel;
    } catch (e) {
      throw Exception("Error : ${e.toString()}");
    }
  }

  @override
  Future<RecommendedModel> getRecommendedMovies(int recommendedPage) async {
    try {
      RecommendedModel recommended = await homeRemoteDS.getRecommendedMovies(recommendedPage);
      return recommended;
    } catch (e) {
      throw Exception("Error : ${e.toString()}");
    }
  }

  @override
  Future<MovieDetailsModel> getMovieDetails(String idValue) async {
    try {
      MovieDetailsModel movieDetailsModel =
          await homeRemoteDS.getMovieDetails(idValue);
      return movieDetailsModel;
    } catch (e) {
      throw Exception("Error : ${e.toString()}");
    }
  }

  @override
  Future<SimilarModel> getSimilarMovies(String movieId,int similarPage) async {
    try {
      SimilarModel similarModel = await homeRemoteDS.getSimilarMovies(movieId,similarPage);
      return similarModel;
    } catch (e) {
      throw Exception("Error : ${e.toString()}");
    }
  }
}
