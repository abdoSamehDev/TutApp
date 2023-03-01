import 'dart:ui';

import 'package:advanced_flutter_arabic/presentation/resources/language_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';

const String prefsLangKey = "LANG_KEY";
const String prefsOnBoardingScreenViewed = "ON_BOARDING_SCREEN_VIEWED_KEY";
const String prefsIsUserLoggedIn = "IS_USER_LOGGED_IN_KEY";

class AppPreferences {
  final SharedPreferences _preferences;

  AppPreferences(this._preferences);

  Future<String> getAppLanguage() async {
    String? language = _preferences.getString(prefsLangKey);
    if (language != null && language.isNotEmpty) {
      return language;
    } else {
      return LanguageType.english.getValue();
    }
  }

  Future changeAppLanguage() async{
    String currentLanguage = await getAppLanguage();
    if(currentLanguage == LanguageType.arabic.getValue()){
      _preferences.setString(prefsLangKey, LanguageType.english.getValue());
    } else{
      _preferences.setString(prefsLangKey, LanguageType.arabic.getValue());
    }
  }

  Future<Locale> getAppLocale() async{
    String currentLanguage = await getAppLanguage();
    if(currentLanguage == LanguageType.arabic.getValue()){
     return arabicLocale;
    } else{
      return englishLocale;
    }
  }

  //on boarding
  Future setOnBoardingScreenViewed() async {
    _preferences.setBool(prefsOnBoardingScreenViewed, true);
  }

  Future<bool> isOnBoardingScreenViewed() async {
    return _preferences.getBool(prefsOnBoardingScreenViewed) ?? false;
  }

  //login
  Future setUserLoggedIn() async {
    _preferences.setBool(prefsIsUserLoggedIn, true);
  }

  Future<bool> isUserLoggedIn() async {
    return _preferences.getBool(prefsIsUserLoggedIn) ?? false;
  }

  //logout
  Future setUserLoggOut() async {
    _preferences.setBool(prefsIsUserLoggedIn, false);
  }
}
