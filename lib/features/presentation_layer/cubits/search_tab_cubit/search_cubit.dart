import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/core/utiles/variables.dart';
import 'package:movies_app/features/data_layer/models/search_model.dart';
import 'package:movies_app/features/domain_layer/usecases/search_usecase.dart';
import 'package:movies_app/features/presentation_layer/cubits/search_tab_cubit/search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  SearchUseCase searchUseCase;

  SearchCubit({required this.searchUseCase}) : super(SearchInitialState());

  static SearchCubit get(context) => BlocProvider.of(context);

  /// Search Movies
  Future<void> getSearch(String searchMovie,int searchPage) async {
    if(Variables.isEndSearch == true) return ;
    try {
      emit(SearchLoadingState());
      SearchModel searchModel = await searchUseCase.getSearch(searchMovie,searchPage);
      Variables.searchResults = searchModel.results ?? [];
      if(Variables.searchResults.isEmpty){
        Variables.isEndSearch == true;
      }
      if(Variables.newSearchPagination.isEmpty){
        Variables.newSearchPagination = Variables.searchResults ;
      }else if (Variables.newSearchPagination.isNotEmpty){
        if(Variables.searchPage == 1){
          Variables.newSearchPagination = Variables.searchResults;
        }else{
          Variables.newSearchPagination.addAll(Variables.searchResults);
        }
      }
      emit(SearchSuccessState());
    } catch (e) {
      emit(SearchErrorState(errorMessage: "Error : ${e.toString()}"));
    }
  }}
