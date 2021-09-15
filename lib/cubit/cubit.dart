import 'package:eg_news_app/cubit/states.dart';
import 'package:eg_news_app/models/news_model.dart';
import 'package:eg_news_app/modules/business/business_screen.dart';
import 'package:eg_news_app/modules/science/science_screen.dart';
import 'package:eg_news_app/modules/sport/sport_screen.dart';
import 'package:eg_news_app/shared/network/local/cashed_helper.dart';
import 'package:eg_news_app/shared/network/remote/dio_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(InitialState());

  static AppCubit get(BuildContext context) => BlocProvider.of(context);

  int currentIndex = 0;

  int inProgress = 0;

  bool isDark = CashedHelper.getData(key: 'isDark') ?? false;

  void changeThemeMode({
    bool? fromCashed,
  }) {
    if (fromCashed != null) {
      isDark = fromCashed;
    } else {
      isDark = !isDark;
    }
    CashedHelper.putData(key: 'isDark', value: isDark);
    emit(ChangeChangeThemeModeState());
  }

  List<SalomonBottomBarItem> items = [
    SalomonBottomBarItem(
      icon: const Icon(
        Icons.business,
      ),
      title: const Text('Business'),
    ),
    SalomonBottomBarItem(
      icon: const Icon(
        Icons.sports,
      ),
      title: const Text('Sport'),
    ),
    SalomonBottomBarItem(
      icon: const Icon(
        Icons.science,
      ),
      title: const Text('Science'),
    ),
  ];

  List<Widget> screens = [
    BusinessScreen(),
    SportScreen(),
    ScienceScreen(),
  ];

  List<String> titles = [
    'Business',
    'Sport',
    'Science',
  ];

  void changeBottomNavBarIndex(int index) {
    currentIndex = index;
    emit(ChangeBottomNavBarIndexState());
  }

  NewsModel? businessModel;
  void getBusiness() {
    emit(NewsGetBusinessLoadingStates());
    DioHelper.getData(
      url: 'v2/top-headlines',
      query: {
        'country': 'eg',
        'category': 'business',
        'apiKey': 'ee2a7824476e41788177288a8ce5d16e',
      },
    ).then((value) {
      businessModel = NewsModel.fromJson(value.data);
      emit(NewsGetBusinessSuccessStates());
    }).catchError((error) {
      print(error.toString());
      emit(NewsGetBusinessErrorStates(error.toString()));
    });
  }

  NewsModel? sportModel;
  void getSport() {
    emit(NewsGetSportLoadingStates());
    DioHelper.getData(
      url: 'v2/top-headlines',
      query: {
        'country': 'eg',
        'category': 'sport',
        'apiKey': 'ee2a7824476e41788177288a8ce5d16e',
      },
    ).then((value) {
      sportModel = NewsModel.fromJson(value.data);
      emit(NewsGetSportSuccessStates());
    }).catchError((error) {
      print(error.toString());
      emit(NewsGetSportErrorStates(error.toString()));
    });
  }

  NewsModel? scienceModel;
  void getScience() {
    emit(NewsGetScienceLoadingStates());
    DioHelper.getData(
      url: 'v2/top-headlines',
      query: {
        'country': 'eg',
        'category': 'science',
        'apiKey': 'ee2a7824476e41788177288a8ce5d16e',
      },
    ).then((value) {
      scienceModel = NewsModel.fromJson(value.data);
      emit(NewsGetScienceSuccessStates());
    }).catchError((error) {
      print(error.toString());
      emit(NewsGetScienceErrorStates(error.toString()));
    });
  }

  NewsModel? searchModel;
  void getSearch(String value) {
    emit(NewsGetSearchLoadingStates());

    DioHelper.getData(
      url: 'v2/everything',
      query: {
        'q': value,
        'apiKey': 'ee2a7824476e41788177288a8ce5d16e',
      },
    ).then((value) {
      searchModel = NewsModel.fromJson(value.data);
      emit(NewsGetSearchSuccessStates());
    }).catchError((error) {
      print(error.toString());
      emit(NewsGetSearchErrorStates(error.toString()));
    });
  }
}
