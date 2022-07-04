import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:egynews/Material_bloc/Main_bloc.dart';
import 'package:egynews/Material_bloc/main_state.dart';
import 'package:egynews/bloc/observer.dart';
import 'package:egynews/layout/newsLayout.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'bloc/cubit.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  // SharedPreferences prefs = await SharedPreferences.getInstance();
  // bool? fromShared = prefs.getBool("isDark");
  HttpOverrides.global = MyHttpOverrides();

  BlocOverrides.runZoned(
    () {
      runApp(MyApp());
    },
    blocObserver: MyBlocObserver(),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (context) => NewsCubit()
              ..getBusiness()
              ..getSports()
              ..getScience()
              ..loadAdmobInterstitial()),
        BlocProvider(create: (context) => MainCubit()..getIsDarkFromShared())
      ],
      child: BlocConsumer<MainCubit, MainStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var mainCubit = BlocProvider.of<MainCubit>(context);
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
                iconTheme: IconThemeData(
                  size: 28,
                ),
                dividerTheme: const DividerThemeData(
                    thickness: 2,
                    color: Colors.grey,
                    indent: 20,
                    endIndent: 20),
                scaffoldBackgroundColor: Colors.white,
                primarySwatch: Colors.deepOrange,
                appBarTheme: const AppBarTheme(
                    foregroundColor: Colors.black,
                    color: Colors.white,
                    titleTextStyle: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                    elevation: 0.0,
                    backwardsCompatibility: false,
                    systemOverlayStyle: SystemUiOverlayStyle(
                        statusBarColor: Colors.white,
                        statusBarIconBrightness: Brightness.dark)),
                bottomNavigationBarTheme: const BottomNavigationBarThemeData(
                    elevation: 30,
                    selectedItemColor: Colors.deepOrange,
                    type: BottomNavigationBarType.fixed),
                textTheme: const TextTheme(
                    caption: TextStyle(color: Colors.black, fontSize: 20),
                    bodyText1: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black))),
            darkTheme: ThemeData(
                inputDecorationTheme: const InputDecorationTheme(
                    labelStyle: TextStyle(color: Colors.white),
                    prefixIconColor: Colors.white,
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white))),
                iconTheme: IconThemeData(
                  size: 28,
                ),
                dividerTheme: const DividerThemeData(
                    thickness: 2,
                    color: Colors.white,
                    indent: 20,
                    endIndent: 20),
                scaffoldBackgroundColor: Colors.grey[800],
                primarySwatch: Colors.deepOrange,
                appBarTheme: AppBarTheme(
                    foregroundColor: Colors.white,
                    color: Colors.grey[800],
                    titleTextStyle: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                    elevation: 0.0,
                    backwardsCompatibility: false,
                    systemOverlayStyle: SystemUiOverlayStyle(
                        statusBarColor: Colors.grey[800],
                        statusBarIconBrightness: Brightness.light)),
                bottomNavigationBarTheme: BottomNavigationBarThemeData(
                    backgroundColor: Colors.grey[800],
                    elevation: 30,
                    selectedItemColor: Colors.deepOrange,
                    unselectedItemColor: Colors.white,
                    type: BottomNavigationBarType.fixed),
                textTheme: const TextTheme(
                    caption: TextStyle(color: Colors.white, fontSize: 20),
                    bodyText1: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white))),
            themeMode: mainCubit.isDark ? ThemeMode.dark : ThemeMode.light,
            home: NewsLayout(),
          );
        },
      ),
    );
  }
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
