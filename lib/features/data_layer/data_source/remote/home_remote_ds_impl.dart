import 'package:dio/dio.dart';
import 'package:movies_app/core/api/api_manager.dart';
import 'package:movies_app/core/api/end_point.dart';
import 'package:movies_app/features/data_layer/models/movie_details_model.dart';
import 'package:movies_app/features/data_layer/models/new_releases_model.dart';
import 'package:movies_app/features/data_layer/models/popular_model.dart';
import 'package:movies_app/features/data_layer/models/recommended_model.dart';
import 'package:movies_app/features/data_layer/models/similar_model.dart';

import 'home_remote_ds.dart';

class HomeRemoteDsImpl implements HomeRemoteDS {
  HomeRemoteDsImpl();

  @override
  Future<PopularModel> getPopularMovies(int popularPage) async {
    ApiManager apiManager = ApiManager();
    Response response = await apiManager.getData(EndPoints.popular,parameter: {
      "page" : popularPage
    });
    PopularModel popularModel = PopularModel.fromJson(response.data);
    return popularModel;
  }

  @override
  Future<NewReleasesModel> getNewReleasesMovies(int newReleasesPage) async {
    ApiManager apiManager = ApiManager();
    Response response = await apiManager.getData(EndPoints.newReleases,parameter: {
      "page" : newReleasesPage
    });
    NewReleasesModel newReleasesModel =
        NewReleasesModel.fromJson(response.data);
    return newReleasesModel;
  }

  @override
  Future<RecommendedModel> getRecommendedMovies(int recommendedPage) async {
    ApiManager apiManager = ApiManager();
    Response response = await apiManager.getData(EndPoints.recommended,parameter: {
      "page" : recommendedPage
    });
    RecommendedModel recommendedModel =
        RecommendedModel.fromJson(response.data);
    return recommendedModel;
  }

  @override
  Future<MovieDetailsModel> getMovieDetails(idValue) async {
    try {
      ApiManager apiManager = ApiManager();
      Response response =
          await apiManager.getData(EndPoints.movieDetails + idValue);
      MovieDetailsModel movieDetailsModel =
          MovieDetailsModel.fromJson(response.data);
      return movieDetailsModel;
    } catch (e) {
      throw Exception("Error : ${e.toString()}");
    }
  }

  @override
  Future<SimilarModel> getSimilarMovies(String movieId, int similarPage) async {
    try {
      ApiManager apiManager = ApiManager();
      Response response = await apiManager
          .getData(EndPoints.similarBefore + movieId + EndPoints.similarAfter,parameter: {
        "page" : similarPage
      });
      SimilarModel similarModel = SimilarModel.fromJson(response.data);
      return similarModel;
    } catch (e) {
      throw Exception("Error : ${e.toString()}");
    }
  }
}
