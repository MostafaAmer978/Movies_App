abstract class SearchState {}

class SearchInitialState extends SearchState {}

class SearchLoadingState extends SearchState {}

class SearchErrorState extends SearchState {
  String errorMessage;

  SearchErrorState({required this.errorMessage});
}

class SearchSuccessState extends SearchState {}

class SearchEndState extends SearchState {}

