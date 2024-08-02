import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:odaibaklo/moduls/setting/setting_screen.dart';
import 'package:odaibaklo/shared/cubit/states.dart';
import 'package:odaibaklo/shared/network/local/cache_helper.dart';
import 'package:odaibaklo/shared/network/remote/dio_helper.dart';

import '../../moduls/business/business_screen.dart';
import '../../moduls/science/science_screen.dart';
import '../../moduls/sports/sports_screen.dart';
class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(NewsInitialState());

  static AppCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;

  List<String> appBarTitle = [
    "BusinessScreen",
    "SportsScreen",
    "ScienceScreen",
  ];
  List<BottomNavigationBarItem> itemList = [
    BottomNavigationBarItem(icon: Icon(Icons.business), label: "HOME"),
    BottomNavigationBarItem(icon: Icon(Icons.sports_baseball_outlined), label: "SPORTS"),
    BottomNavigationBarItem(icon: Icon(Icons.science), label: "Science"),
  ];
  List<Widget> itemScreen = [
    BusinessScreen(),
    SportsScreen(),
    ScienceScreen(),
    SettingScreen(),
  ];

  void BottomNavChangeItemIndex(int currentIndex) {
    this.currentIndex = currentIndex;
    if (currentIndex == 1) {
      getSports();
    }
    if (currentIndex == 2) {
      getScience();
    }
    emit(BottomBarChangeState());
  }

  List<dynamic> business = [];
  List<dynamic> sports = [];
  List<dynamic> science = [];

  void getBusiness() {
    emit(GetBusinessDataLoadingState());
    DioHelper.getData(
        url: "v2/top-headlines",
        query: {
          "country": "eg",
          "category": "business",
          "apiKey": "36ee2a698b4f4169a5103865971687ee",
        }).then((value) {
      business = value.data["articles"];
      emit(GetBusinessDataSuccessfulState());
    }).catchError((onError) {
      print(onError);
      emit(GetBusinessDataErrorState(onError.toString()));
    });
  }

  void getSports() {
    emit(GetSportsDataLoadingState());

    if (sports.length == 0) {
      DioHelper.getData(
          url: "v2/top-headlines",
          query: {
            "country": "eg",
            "category": "sports",
            "apiKey": "36ee2a698b4f4169a5103865971687ee",
          }).then((value) {
        sports = value.data["articles"];
        emit(GetSportsDataSuccessfulState());
      }).catchError((onError) {
        print(onError);
        emit(GetSportsDataErrorState(onError.toString()));
      });
    }
  }

  void getScience() {
    emit(GetScienceDataLoadingState());
    if (science.length == 0) {
      DioHelper.getData(
          url: "v2/top-headlines",
          query: {
            "country": "eg",
            "category": "science",
            "apiKey": "36ee2a698b4f4169a5103865971687ee",
          }).then((value) {
        science = value.data["articles"];
        emit(GetScienceDataSuccessfulState());
      }).catchError((onError) {
        print(onError);
        emit(GetScienceDataErrorState(onError.toString()));
      });
    }
  }

  bool isDark = false;
List<dynamic> searchList =[];
  void changeAppTheme({bool? fromPref}) {

    if(fromPref != null){
       isDark = fromPref;
    }else{
      isDark = !isDark;
    }
    CacheHelper.putData(key: "isDark", value: isDark).then((value) {
      emit(ChangeThemeState());
    },);

  }


  void getSearch({ String? query}){
    emit(GetSearchDataLoadingState());
DioHelper.getData(url: 'v2/everything',
    query: {
       'q':'$query',
       'apiKey':'36ee2a698b4f4169a5103865971687ee',
    }
).then((value) {
  searchList = value.data['articles'];
  emit(GetSearchDataSuccessfulState());
},).catchError((onError){
  print(onError);
  emit(GetSearchDataErrorState(onError));
});
  }
}