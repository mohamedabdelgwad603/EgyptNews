import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'main_state.dart';

class MainCubit extends Cubit<MainStates> {
  MainCubit() : super(MainIntialState());
  //change ThemeMode

  bool isDark = true;
  changeThemeMode() async {
    isDark = !isDark;
    SharedPreferences pre = await SharedPreferences.getInstance();
    pre.setBool("isDark", isDark);
    emit(NewsChangeThemeModeState());
  }

  getIsDarkFromShared() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool? fromShared = prefs.getBool("isDark");
    if (fromShared != null) {
      isDark = fromShared;
      emit(NewsgetIsDarkfromssharedState());
    }
  }
}
