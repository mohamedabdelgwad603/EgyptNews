import 'package:admob_flutter/admob_flutter.dart';
import 'package:dio/dio.dart';

import 'package:flutter/material.dart';
import 'package:egynews/bloc/states.dart';
import 'package:bloc/bloc.dart';
import 'package:egynews/modules/business_screen.dart';
import 'package:egynews/modules/science_screen.dart';
import 'package:egynews/modules/sport_screen.dart';

import '../admob/AdsManger.dart';

class NewsCubit extends Cubit<NewsStates> {
  NewsCubit() : super(NewsIntialState());
  //BottomNavigation state
  int currentIndex = 0;
  List<Widget> screens = [
    BusinessScreen(),
    SportsScreen(),
    ScienceScreen(),
  ];
  List<BottomNavigationBarItem> NavBarItems = const [
    BottomNavigationBarItem(
        icon: Icon(Icons.business_center_rounded), label: "أعمال"),
    BottomNavigationBarItem(
        icon: Icon(Icons.sports_baseball_sharp), label: "رياضة"),
    BottomNavigationBarItem(
        icon: Icon(Icons.all_inclusive_rounded), label: "عام"),
  ];
  changeBottomNavIndex(int index) {
    currentIndex = index;
    emit(NewsChangeBottomNavIndexState());
  }

  //  Get business state
  List<dynamic> business = [];
  void getBusiness() async {
    emit(NewsLoadingBusinessState());
    await Dio(BaseOptions(
            baseUrl: 'https://newsapi.org/', receiveDataWhenStatusError: true))
        .get('v2/top-headlines', queryParameters: {
      "country": "eg",
      "category": "business",
      "apiKey": "1dd8ff426ffe4a36af8582d2f425526a",
    }).then((value) {
      business = value.data['articles'];
      print(value.data['articles']);

      emit(NewsGetBusinessSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(NewsGetBusinessErrorState());
    });
  }

  List<dynamic> sports = [];
  void getSports() async {
    emit(NewsLoadingSportsState());
    await Dio(BaseOptions(
            baseUrl: 'https://newsapi.org/', receiveDataWhenStatusError: true))
        .get('v2/top-headlines', queryParameters: {
      "country": "eg",
      "category": "sports",
      "apiKey": "1dd8ff426ffe4a36af8582d2f425526a",
    }).then((value) {
      sports = value.data['articles'];
      print(value.data['articles']);
      emit(NewsGetSportsSuccessState());

      emit(NewsGetSportsSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(NewsGetSportsErrorState());
    });
  }

  List<dynamic> science = [];
  void getScience() async {
    emit(NewsLoadingScienceState());
    await Dio(BaseOptions(
            baseUrl: 'https://newsapi.org/', receiveDataWhenStatusError: true))
        .get('v2/top-headlines', queryParameters: {
      "country": "eg",
      "category": "general",
      "apiKey": "1dd8ff426ffe4a36af8582d2f425526a",
    }).then((value) {
      science = value.data['articles'];
      print(value.data['articles']);

      emit(NewsGetScienceSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(NewsGetScienceErrorState());
    });
  }

  // search list
  List<dynamic> searchList = [];
  void search(String str) async {
    emit(NewsLoadingSearchState());
    await Dio(BaseOptions(
            baseUrl: 'https://newsapi.org/', receiveDataWhenStatusError: true))
        .get('v2/everything', queryParameters: {
      "q": "$str",
      "apiKey": "1dd8ff426ffe4a36af8582d2f425526a",
    }).then((value) {
      searchList = value.data['articles'];
      print(value.data['articles']);

      emit(NewsGetSearchSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(NewsGetSearchErrorState());
    });
  }

  searchapp(String str) {
    searchList = [];
    emit(NewsLoadingSearchState());
    business.forEach((element) {
      if (element['title'].toString().contains(str) && str.isNotEmpty) {
        searchList.add(element);
      }
    });
    science.forEach((element) {
      if (element['title'].toString().contains(str) && str.isNotEmpty) {
        searchList.add(element);
      }
    });
    sports.forEach((element) {
      if (element['title'].toString().contains(str) && str.isNotEmpty) {
        searchList.add(element);
      }
    });
    emit(NewsGetSearchSuccessState());
  }

  // AdmobInterstitial
  AdmobInterstitial? interstitialAd;
  loadAdmobInterstitial() {
    interstitialAd = AdmobInterstitial(
      adUnitId: AdsManager.interstitialAdUnitId,
      listener: (AdmobAdEvent event, Map<String, dynamic>? args) {
        if (event == AdmobAdEvent.closed) {
          interstitialAd!.load();
          emit(NewsLoadingSportsState());
        }
      },
    );

    interstitialAd!.load();
    emit(NewsLoadingSportsState());
  }

  disposeAdmobInterstitial() {
    interstitialAd!.dispose();
  }
}
