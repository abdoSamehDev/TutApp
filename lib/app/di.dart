import 'package:advanced_flutter_arabic/app/app_prefs.dart';
import 'package:advanced_flutter_arabic/data/data_source/remote_data_source.dart';
import 'package:advanced_flutter_arabic/data/network/app_api.dart';
import 'package:advanced_flutter_arabic/data/network/dio_factory.dart';
import 'package:advanced_flutter_arabic/data/network/network_info.dart';
import 'package:advanced_flutter_arabic/domain/repository/repository.dart';
import 'package:advanced_flutter_arabic/domain/use_case/forgot_password_use_case.dart';
import 'package:advanced_flutter_arabic/domain/use_case/login_use_case.dart';
import 'package:advanced_flutter_arabic/presentation/forgot_password/view_model/forgot_password_view_model.dart';
import 'package:advanced_flutter_arabic/presentation/login/view_model/login_view_model.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../data/repository/repository_impl.dart';

final instance = GetIt.instance;

Future initAppModule() async {
  // app module is a module where we put all generic dependencies.
  //shared prefs instance
  final sharedPrefs = await SharedPreferences.getInstance();
  instance.registerLazySingleton<SharedPreferences>(() => sharedPrefs);

  //app prefs instance
  instance
      .registerLazySingleton<AppPreferences>(() => AppPreferences(instance()));

  //network info instance
  instance.registerLazySingleton<NetworkInfo>(
      () => NetworkInfoImpl(InternetConnectionChecker()));

  //dio factory instance
  instance.registerLazySingleton<DioFactory>(() => DioFactory(instance()));

  //app service client instance
  Dio dio = await instance<DioFactory>().getDio();
  instance.registerLazySingleton<AppServiceClient>(() => AppServiceClient(dio));

  //remote data source instance
  instance.registerLazySingleton<RemoteDataSource>(
      () => RemoteDataSourceImpl(instance()));

  //repository instance
  instance.registerLazySingleton<Repository>(
      () => RepositoryImpl(instance(), instance()));
}

void initLoginModule() {
  if (!GetIt.I.isRegistered<LoginUseCase>()) {
    instance.registerFactory<LoginUseCase>(() => LoginUseCase(instance()));
    instance.registerFactory<LoginViewModel>(() => LoginViewModel(instance()));
  }
}

void initForgotPasswordModule() {
  if (!GetIt.I.isRegistered<ForgotPasswordViewModel>()) {
    instance.registerFactory<ForgotPasswordUseCase>(() => ForgotPasswordUseCase(instance()));
    instance.registerFactory<ForgotPasswordViewModel>(() => ForgotPasswordViewModel(instance()));
  }
}
