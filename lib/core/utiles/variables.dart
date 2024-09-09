import 'package:movies_app/features/data_layer/models/category_model.dart';
import 'package:movies_app/features/data_layer/models/movie_details_model.dart';
import 'package:movies_app/features/data_layer/models/new_releases_model.dart';
import 'package:movies_app/features/data_layer/models/popular_model.dart';
import 'package:movies_app/features/data_layer/models/recommended_model.dart';
import 'package:movies_app/features/data_layer/models/search_model.dart';
import 'package:movies_app/features/data_layer/models/similar_model.dart';
import 'package:movies_app/features/data_layer/models/watchlist_model.dart';

class Variables {
  static int popularPage = 1;
  static int newReleasesPage = 1;
  static int recommendedPage = 1;
  static int searchPage = 1;
  static int similarPage = 1;
  static int categoryPage = 1;

  static List<PopularResults> resultsPopular = [];
  static List<NewReleasesResults> resultsNewReleases = [];
  static List<RecommendedResults> resultsRecommended = [];
  static List<SimilarResults> resultsSimilar = [];
  static List<SearchResults> searchResults = [];
  static List<CategoryResults>? categoryResults;
  static MovieDetailsModel? movieDetailsModel;

  static List<PopularResults> newPopularPagination = [];
  static List<NewReleasesResults> newReleasesPagination = [];
  static List<RecommendedResults> newRecommendedPagination = [];
  static List<SimilarResults> newSimilarPagination = [];
  static List<SearchResults> newSearchPagination = [];
  static List<CategoryResults> newCategoryPagination = [];

  static List<WatchlistModel> watchlistMovies = [];

  static bool isEndNewReleases = false;
  static bool isEndRecommended = false;
  static bool isEndSimilar = false;
  static bool isEndSearch = false;

}
