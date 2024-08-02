abstract class AppStates {}

class NewsInitialState extends AppStates {}
class BottomBarChangeState extends AppStates {}

class GetBusinessDataSuccessfulState extends AppStates {}
class GetBusinessDataErrorState extends AppStates {
  final String error;
  GetBusinessDataErrorState(this.error);
}
class GetBusinessDataLoadingState extends AppStates {}

class GetSportsDataSuccessfulState extends AppStates {}
class GetSportsDataErrorState extends AppStates {
  final String error;
  GetSportsDataErrorState(this.error);
}
class GetSportsDataLoadingState extends AppStates {}

class GetScienceDataSuccessfulState extends AppStates {}
class GetScienceDataErrorState extends AppStates {
  final String error;
  GetScienceDataErrorState(this.error);
}
class GetScienceDataLoadingState extends AppStates {}

class GetSearchDataSuccessfulState extends AppStates {}
class GetSearchDataErrorState extends AppStates {
  final String error;
  GetSearchDataErrorState(this.error);
}
class GetSearchDataLoadingState extends AppStates {}

class ChangeThemeState extends AppStates {}