import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/core/utiles/variables.dart';
import 'package:movies_app/features/data_layer/models/category_model.dart';
import 'package:movies_app/features/data_layer/models/movie_list_genres_model.dart';
import 'package:movies_app/features/domain_layer/usecases/browse_usecase.dart';

import 'browse_state.dart';

class BrowseCubit extends Cubit<BrowseState> {
  BrowseUseCase browseUseCase;
  bool navigator = false;
  int? index;
  List<Genres>? genres;


  BrowseCubit({required this.browseUseCase}) : super(BrowseInitialState());

  static BrowseCubit get(context) => BlocProvider.of(context);

  void getMovieListGenres() async {
    try {
      emit(BrowseLoadingState());
      MovieListGenresModel movieListGenresModel =
          await browseUseCase.getMovieListGenres();
      genres = movieListGenresModel.genres;
      emit(BrowseSuccessState());
    } catch (e) {
      emit(BrowseErrorState(errorMessage: "Error : ${e.toString()}"));
    }
  }

  /// Category Movies
  void getCategoryMovies(String categoryId,int categoryPage) async {
    if(Variables.categoryPage > 500) return;
    try {
      if(Variables.categoryPage == 1){
        emit(BrowseLoadingState());
      }
      CategoryModel categoryModel = await browseUseCase.getCategoryMovies(categoryId,categoryPage);
      Variables.categoryResults = categoryModel.results ?? [];
      if(Variables.newCategoryPagination.isEmpty){
        Variables.newCategoryPagination = Variables.categoryResults ?? [];
      }else if (Variables.newCategoryPagination.isNotEmpty){
        Variables.newCategoryPagination.addAll(Variables.categoryResults ?? []);
      }
      emit(BrowseSuccessState());
    } catch (e) {
      emit(BrowseErrorState(errorMessage: "Error : ${e.toString()}"));
    }
  }

  void clickNavigator(){
    navigator = !navigator ;
    emit(BrowseNavigatorState(navigator: navigator));

  }
}
