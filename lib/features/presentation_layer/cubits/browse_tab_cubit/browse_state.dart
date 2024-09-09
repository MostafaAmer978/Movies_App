abstract class BrowseState {}

class BrowseInitialState extends BrowseState {}

class BrowseLoadingState extends BrowseState {}

class BrowseNavigatorState extends BrowseState {
  bool navigator;
  BrowseNavigatorState({required this.navigator});
}

class BrowseErrorState extends BrowseState {
  String? errorMessage;

  BrowseErrorState({required this.errorMessage});
}

class BrowseSuccessState extends BrowseState {}

