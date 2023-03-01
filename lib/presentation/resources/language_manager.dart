import 'package:flutter/material.dart';

enum LanguageType{
  english,
  arabic
}

const String localisationsPath = "assets/translations";


const String english = "en";
const String arabic = "ar";

const Locale englishLocale = Locale("en", "US");
const Locale arabicLocale  = Locale("ar", "SA");

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