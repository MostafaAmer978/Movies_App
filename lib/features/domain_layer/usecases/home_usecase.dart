import 'package:movies_app/features/data_layer/models/movie_details_model.dart';
import 'package:movies_app/features/data_layer/models/new_releases_model.dart';
import 'package:movies_app/features/data_layer/models/popular_model.dart';
import 'package:movies_app/features/data_layer/models/recommended_model.dart';
import 'package:movies_app/features/data_layer/models/similar_model.dart';
import 'package:movies_app/features/domain_layer/repository/home_repository.dart';

class HomeUseCase {
  HomeRepository homeRepository;

  HomeUseCase({required this.homeRepository});

  Future<PopularModel> getPopularMovies(int popularPage) => homeRepository.getPopularMovies(popularPage);

  Future<NewReleasesModel> getNewReleasesMovies(int newReleasesPage) => homeRepository.getNewReleasesMovies(newReleasesPage);

  Future<RecommendedModel> getRecommendedMovies(int recommendedPage) => homeRepository.getRecommendedMovies(recommendedPage);

  Future<MovieDetailsModel> getMovieDetails(String movieId) => homeRepository.getMovieDetails(movieId);

  Future<SimilarModel> getSimilarMovies(String movieId,int similarPage) => homeRepository.getSimilarMovies( movieId , similarPage);

}
