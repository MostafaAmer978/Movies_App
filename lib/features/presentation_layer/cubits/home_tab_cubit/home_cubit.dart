import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/core/utiles/variables.dart';
import 'package:movies_app/features/data_layer/models/movie_details_model.dart';
import 'package:movies_app/features/data_layer/models/new_releases_model.dart';
import 'package:movies_app/features/data_layer/models/popular_model.dart';
import 'package:movies_app/features/data_layer/models/recommended_model.dart';
import 'package:movies_app/features/data_layer/models/similar_model.dart';
import 'package:movies_app/features/data_layer/models/watchlist_model.dart';
import 'package:movies_app/features/domain_layer/usecases/home_usecase.dart';
import 'package:movies_app/features/presentation_layer/pages/firebase_functions.dart';
import 'package:movies_app/features/presentation_layer/pages/tabs/browse_tab.dart';
import 'package:movies_app/features/presentation_layer/pages/tabs/home_tab.dart';
import 'package:movies_app/features/presentation_layer/pages/tabs/search_tab.dart';
import 'package:movies_app/features/presentation_layer/pages/tabs/watchlist_tab.dart';


import 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeUseCase homeUseCase;
  int index = 0;

  List<Widget> tabs = [
    const HomeTab(),
    SearchTab(),
    const BrowseTab(),
    const WatchlistTab()
  ];

  HomeCubit({required this.homeUseCase}) : super(HomeInitialState());

  static HomeCubit get(context) => BlocProvider.of(context);

  /// Popular Movies
  Future<void> getPopularMovies(int popularPage) async {
    if (Variables.popularPage > 500) return ;
      try {
        emit(HomeLoadingState());
        PopularModel popularModel =
            await homeUseCase.getPopularMovies(Variables.popularPage);
        Variables.resultsPopular = popularModel.results ?? [];

        if (Variables.newPopularPagination.isEmpty) {
          Variables.newPopularPagination = Variables.resultsPopular;
        } else if (Variables.newPopularPagination.isNotEmpty) {
          Variables.newPopularPagination.addAll(Variables.resultsPopular);
        }

        emit(HomeSuccessState());
      } catch (e) {
        emit(HomeErrorState(errorMessage: "Error : ${e.toString()}"));
      }
  }

  /// New Releases Movies
  Future<void> getNewReleasesMovies(int newReleasesPage) async {
    if (Variables.isEndNewReleases) return;
    try {
      emit(HomeLoadingState());
      NewReleasesModel newReleasesModel =
          await homeUseCase.getNewReleasesMovies(++Variables.newReleasesPage);
      if (newReleasesModel.results!.isEmpty) {
        Variables.isEndNewReleases = true;
        emit(HomeNewReleasesEndState());
        return;
      }
      Variables.resultsNewReleases = newReleasesModel.results ?? [];
      if (Variables.newReleasesPagination.isEmpty) {
        Variables.newReleasesPagination = Variables.resultsNewReleases;
      } else if (Variables.newReleasesPagination.isNotEmpty) {
        Variables.newReleasesPagination.addAll(Variables.resultsNewReleases);
      }
      emit(HomeSuccessState());
    } catch (e) {
      emit(HomeErrorState(errorMessage: "Error : ${e.toString()}"));
    }
  }

  /// Recommended Movies
  Future<void> getRecommendedMovies(int recommendedPage) async {
    if (Variables.isEndRecommended) return;
    try {
      emit(HomeLoadingState());

      RecommendedModel recommendedModel =
          await homeUseCase.getRecommendedMovies(++Variables.recommendedPage);
      if (recommendedModel.results!.isEmpty) {
        Variables.isEndRecommended = true;
        emit(HomeRecommendedEndState());
        return;
      }
      Variables.resultsRecommended = recommendedModel.results ?? [];
      if (Variables.newRecommendedPagination.isEmpty) {
        Variables.newRecommendedPagination = Variables.resultsRecommended;
      } else if (Variables.newRecommendedPagination.isNotEmpty) {
        Variables.newRecommendedPagination.addAll(Variables.resultsRecommended);
      }

      emit(HomeSuccessState());
    } catch (e) {
      emit(HomeErrorState(errorMessage: "Error : ${e.toString()}"));
    }
  }

  /// Movie Details
  Future<void> getMovieDetails(String movieId) async {
    try {
      emit(HomeLoadingState());
      MovieDetailsModel resultMovieDetailsModel =
          await homeUseCase.getMovieDetails(movieId);
      Variables.movieDetailsModel = resultMovieDetailsModel;
      emit(HomeSuccessState());
    } catch (e) {
      emit(HomeErrorState(errorMessage: "Error : ${e.toString()}"));
    }
  }

  /// Similar Movies
  Future<void> getSimilarMovie(String movieId, int similarPage) async {
    if (Variables.similarPage <= 500) {
      try {
        SimilarModel similarModel =
        await homeUseCase.getSimilarMovies(movieId, similarPage);

        Variables.resultsSimilar = similarModel.results ?? [];
        if (Variables.newSimilarPagination.isEmpty) {
          Variables.newSimilarPagination = Variables.resultsSimilar;
        } else if (Variables.newSimilarPagination.isNotEmpty) {
          Variables.newSimilarPagination.addAll(Variables.resultsSimilar);
        }
        emit(HomeSuccessState());

      } catch (e) {
        emit(HomeErrorState(errorMessage: "Error : ${e.toString()}"));
    }
    }else if (Variables.similarPage > 500 && Variables.similarPage == 501 ){
      emit(HomeSimilarEndState());
      return ;
    }
  }

  /// Add to Watchlist - addAndDeleteMovie
  void addToWatchlist(WatchlistModel watchlistModel){
    if (Variables.watchlistMovies.contains(watchlistModel)) {
      Variables.watchlistMovies.remove(watchlistModel);
    } else {
      Variables.watchlistMovies.add(watchlistModel);
    }

    emit(AddToWatchlist(watchlistModel: Variables.watchlistMovies));
  }


  /// isSaved
  bool isSaved(WatchlistModel watchlistModel) {
    return Variables.watchlistMovies.contains(watchlistModel);
  }



  void selectedIndexTab(int index) {
    this.index = index;
    if (index == 1) {
      emit(SearchTabState(tab: tabs[1]));
    } else if (index == 2) {
      emit(BrowseTabState(tab: tabs[2]));
    } else if (index == 3) {
      emit(WatchlistTabState(tab: tabs[3]));
    } else {
      emit(HomeTabState(tab: tabs[0]));
    }
  }
}
