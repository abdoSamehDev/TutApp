import 'package:advanced_flutter_arabic/presentation/resources/language_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';


const String prefsLangKey = "KEY";
class AppPreferences{
  final SharedPreferences _preferences;

  AppPreferences(this._preferences);

  Future<String> getAppLanguage() async{
    String? language = _preferences.getString(prefsLangKey);
    if(language != null && language.isNotEmpty){
      return language;
    } else{
      return LanguageType.english.getValue();
    }
  }
}