import 'package:advanced_flutter_arabic/app/constants.dart';

extension NonNulString on String?{
  String orEmpty(){
    if(this == null) {
      return Constants.empty;
    } else{
      return this!;
    }
  }
}

extension NonNulInt on int?{
  int orZero(){
    if(this == null) {
      return Constants.zero;
    } else{
      return this!;
    }
  }
}