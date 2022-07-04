import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:egynews/bloc/cubit.dart';
import 'package:egynews/modules/search.dart';

import '../Material_bloc/Main_bloc.dart';
import '../bloc/states.dart';

class NewsLayout extends StatefulWidget {
  @override
  State<NewsLayout> createState() => _NewsLayoutState();
}

class _NewsLayoutState extends State<NewsLayout> {
  // AdmobInterstitial? interstitialAd;
/*
  @override
  void initState() {
    super.initState();

    //Ads
     interstitialAd = AdmobInterstitial(
      adUnitId: AdsManager.interstitialAdUnitId,
      listener: (AdmobAdEvent event, Map<String, dynamic>? args) {
        if (event == AdmobAdEvent.closed) interstitialAd!.load();
      },
    );

    interstitialAd!.load();
  }*/

  /* @override
  void dispose() {
    interstitialAd!.dispose();
    super.dispose();
  }*/

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewsStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = BlocProvider.of<NewsCubit>(context);
          return Directionality(
            textDirection: TextDirection.rtl,
            child: Scaffold(
                appBar: AppBar(
                  actions: [
                    IconButton(
                        onPressed: () {
                          Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: ((context) => SearchScreen())))
                              .then((value) {
                            BlocProvider.of<NewsCubit>(context).searchList = [];
                            cubit.interstitialAd!.show();
                          });
                        },
                        icon: Icon(
                          Icons.search,
                          color: BlocProvider.of<MainCubit>(context).isDark
                              ? Colors.white
                              : Colors.black,
                        )),
                    IconButton(
                        onPressed:
                            BlocProvider.of<MainCubit>(context).changeThemeMode,
                        icon: Icon(Icons.brightness_4_outlined,
                            color: BlocProvider.of<MainCubit>(context).isDark
                                ? Colors.white
                                : Colors.black)),
                  ],
                  title: const Text(
                    "أخبار مصر",
                  ),
                ),
                body: cubit.screens[cubit.currentIndex],
                bottomNavigationBar: BottomNavigationBar(
                    currentIndex: cubit.currentIndex,
                    onTap: (index) {
                      cubit.changeBottomNavIndex(index);
                    },
                    items: cubit.NavBarItems)),
          );
        });
  }
}
