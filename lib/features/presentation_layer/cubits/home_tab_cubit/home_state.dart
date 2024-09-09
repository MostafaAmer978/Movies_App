import 'package:flutter/material.dart';
import 'package:movies_app/features/data_layer/models/watchlist_model.dart';

abstract class HomeState {}

class HomeInitialState extends HomeState {}

class HomePaginationState extends HomeState {}

class HomeLoadingState extends HomeState {}

class HomeErrorState extends HomeState {
  String? errorMessage;

  HomeErrorState({required this.errorMessage});
}

class HomeSuccessState extends HomeState {}

class HomePopularEndState extends HomeState {}

class HomeNewReleasesEndState extends HomeState {}

class HomeRecommendedEndState extends HomeState {}

class HomeSimilarEndState extends HomeState {}


class AddToWatchlist extends HomeState {
  List<WatchlistModel> watchlistModel;

  AddToWatchlist({required this.watchlistModel});
}

class MainInitialState extends HomeState {}

class HomeTabState extends HomeState {
  Widget tab;

  HomeTabState({required this.tab});
}

class SearchTabState extends HomeState {
  Widget tab;

  SearchTabState({required this.tab});
}

class BrowseTabState extends HomeState {
  Widget tab;

  BrowseTabState({required this.tab});
}

class WatchlistTabState extends HomeState {
  Widget tab;

  WatchlistTabState({required this.tab});
}
