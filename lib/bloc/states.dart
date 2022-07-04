abstract class NewsStates {}

class NewsIntialState extends NewsStates {}

class NewsChangeBottomNavIndexState extends NewsStates {}

//get businessNews state
class NewsLoadingBusinessState extends NewsStates {}

class NewsGetBusinessSuccessState extends NewsStates {}

class NewsGetBusinessErrorState extends NewsStates {}

//get sportNews state
class NewsLoadingSportsState extends NewsStates {}

class NewsGetSportsSuccessState extends NewsStates {}

class NewsGetSportsErrorState extends NewsStates {}

//get Science News state
class NewsLoadingScienceState extends NewsStates {}

class NewsGetScienceSuccessState extends NewsStates {}

class NewsGetScienceErrorState extends NewsStates {}

//get search News state
class NewsLoadingSearchState extends NewsStates {}

class NewsGetSearchSuccessState extends NewsStates {}

class NewsGetSearchErrorState extends NewsStates {}

// interstitialAd state
class NewsLoadinterstitialAdState extends NewsStates {}
