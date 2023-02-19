enum LanguageType{
  english,
  arabic
}

const String english = "en";
const String arabic = "ar";

extension LanguageTypeExtension on LanguageType{
  String getValue(){
    switch(this){
      case LanguageType.english:
      return english;
      case LanguageType.arabic:
        return arabic;
    }


    }
}