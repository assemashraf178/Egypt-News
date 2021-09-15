abstract class AppStates {}

class InitialState extends AppStates {}

class ChangeBottomNavBarIndexState extends AppStates {}

class ChangeChangeThemeModeState extends AppStates {}

class NewsGetBusinessLoadingStates extends AppStates {}

class NewsGetBusinessSuccessStates extends AppStates {}

class NewsGetBusinessErrorStates extends AppStates {
  final String error;

  NewsGetBusinessErrorStates(this.error);
}

class NewsGetSportLoadingStates extends AppStates {}

class NewsGetSportSuccessStates extends AppStates {}

class NewsGetSportErrorStates extends AppStates {
  final String error;

  NewsGetSportErrorStates(this.error);
}

class NewsGetScienceLoadingStates extends AppStates {}

class NewsGetScienceSuccessStates extends AppStates {}

class NewsGetScienceErrorStates extends AppStates {
  final String error;

  NewsGetScienceErrorStates(this.error);
}

class NewsGetSearchLoadingStates extends AppStates {}

class NewsGetSearchSuccessStates extends AppStates {}

class NewsGetSearchErrorStates extends AppStates {
  final String error;

  NewsGetSearchErrorStates(this.error);
}
