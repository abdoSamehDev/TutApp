import 'package:advanced_flutter_arabic/data/network/failure.dart';
import 'package:dio/dio.dart';

class ErrorHandler implements Exception {
  late Failure failure;

  ErrorHandler.handle(dynamic error) {
    if (error is DioError) {
failure = _handleError(error);
    }else{
      failure = DataSource.unknown.getFailure();
    }
  }
}

Failure _handleError(DioError error){
  switch (error.type){
    case DioErrorType.connectionTimeout:
      return DataSource.connectTimeout.getFailure();
    case DioErrorType.sendTimeout:
      return DataSource.sendTimeout.getFailure();
    case DioErrorType.receiveTimeout:
      return DataSource.receiveTimeOut.getFailure();
    case DioErrorType.badCertificate:
      return DataSource.unauthorized.getFailure();
    case DioErrorType.badResponse:
      if(error.response != null && error.response?.statusCode != null && error.response?.statusMessage != null){
        return Failure(error.response!.statusCode!, error.response!.statusMessage!);
      } else{
        return DataSource.unknown.getFailure();
      }
    case DioErrorType.cancel:
      return DataSource.cancel.getFailure();
    case DioErrorType.connectionError:
      return DataSource.noInternetConnection.getFailure();
    case DioErrorType.unknown:
      return DataSource.unknown.getFailure();
  }
}

enum DataSource {
  success,
  noContent,
  badRequest,
  forbidden,
  unauthorized,
  notFound,
  internalServerError,
  connectTimeout,
  cancel,
  receiveTimeOut,
  sendTimeout,
  cacheError,
  noInternetConnection,
  unknown
}

extension DataSourceExtention on DataSource {
  Failure getFailure() {
    switch (this) {
      case DataSource.success:
        return Failure(ResponseCode.success, ResponseMessage.success);
      case DataSource.noContent:
        return Failure(ResponseCode.noContent, ResponseMessage.noContent);
      case DataSource.badRequest:
        return Failure(ResponseCode.badRequest, ResponseMessage.badRequest);
      case DataSource.forbidden:
        return Failure(ResponseCode.forbidden, ResponseMessage.forbidden);
      case DataSource.unauthorized:
        return Failure(ResponseCode.unauthorized, ResponseMessage.unauthorized);
      case DataSource.notFound:
        return Failure(ResponseCode.notFound, ResponseMessage.notFound);
      case DataSource.internalServerError:
        return Failure(ResponseCode.internalServerError,
            ResponseMessage.internalServerError);
      case DataSource.connectTimeout:
        return Failure(
            ResponseCode.connectTimeout, ResponseMessage.connectTimeout);
      case DataSource.cancel:
        return Failure(ResponseCode.cancel, ResponseMessage.cancel);
      case DataSource.receiveTimeOut:
        return Failure(
            ResponseCode.receiveTimeOut, ResponseMessage.receiveTimeOut);
      case DataSource.sendTimeout:
        return Failure(ResponseCode.sendTimeout, ResponseMessage.sendTimeout);
      case DataSource.cacheError:
        return Failure(ResponseCode.cacheError, ResponseMessage.cacheError);
      case DataSource.noInternetConnection:
        return Failure(ResponseCode.noInternetConnection,
            ResponseMessage.noInternetConnection);
      case DataSource.unknown:
        return Failure(ResponseCode.unknown, ResponseMessage.unknown);
    }
  }
}

class ResponseCode {
  static const int success = 200; //success with data
  static const int noContent = 201; //success with no data
  static const int badRequest = 400; //failure, API rejected request
  static const int unauthorized = 401; //failure, user is not authorized
  static const int forbidden = 403; //failure, API rejected request
  static const int notFound = 404;
  static const int internalServerError = 500; //failure, crash in server side

  //local status code
  static const int connectTimeout = -1;
  static const int cancel = -2;
  static const int receiveTimeOut = -3;
  static const int sendTimeout = -4;
  static const int cacheError = -5;
  static const int noInternetConnection = -6;
  static const int unknown = -7;
}

class ResponseMessage {
  static const String success = "Success"; //success with data
  static const String noContent = "Success"; //success with no data
  static const String badRequest =
      "Bad request, Try again later"; //failure, API rejected request
  static const String unauthorized =
      "User is unauthorized, Try again later"; //failure, user is not authorized
  static const String forbidden =
      "Forbidden request, Try again later"; //failure, API rejected request
  static const String notFound = "Something went wrong, Try again later";
  static const String internalServerError =
      "Something went wrong, Try again later"; //failure, crash in server side

  //local status message
  static const String connectTimeout = "Timeout error, Try again later";
  static const String cancel = "Request was cancelled, Try again later";
  static const String receiveTimeOut = "Timeout error, Try again later";
  static const String sendTimeout = "Timeout error, Try again later";
  static const String cacheError = "Cache error, Try again later";
  static const String noInternetConnection =
      "Please check your internet connection";
  static const String unknown = "Something went wrong, Try again later";
}

class ApiInternalStatus{
  static const int success = 0;
  static const int failure = 1;
}
