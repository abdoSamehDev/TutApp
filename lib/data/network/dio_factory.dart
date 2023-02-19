import 'package:advanced_flutter_arabic/app/constants.dart';
import 'package:dio/dio.dart';

const String contentType = "content-type";
const String applicationJson = "application/json";
const String accept = "accept";
const String authorization = "authorization";
const String defaultLanguage = "language";

class DioFactory {
  Future<Dio> getDio() async {
    Dio dio = Dio();

    Duration timeOut = const Duration(seconds: 60);
    Map<String, dynamic> headers = {
      contentType: applicationJson,
      accept: applicationJson,
      authorization: "SEND TOKEN HERE",
      defaultLanguage: "en" //todo: get lang from app prefs
    };
    dio.options = BaseOptions(
        baseUrl: Constants.baseUrl,
        headers: headers,
        sendTimeout: timeOut,
        receiveTimeout: timeOut);

    return dio;
  }
}
