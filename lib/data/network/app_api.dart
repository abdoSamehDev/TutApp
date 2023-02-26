import 'package:advanced_flutter_arabic/app/constants.dart';
import 'package:advanced_flutter_arabic/data/responses/responses.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';

part 'app_api.g.dart';

@RestApi(baseUrl: Constants.baseUrl)
abstract class AppServiceClient {
  factory AppServiceClient(Dio dio, {String baseUrl}) = _AppServiceClient;

  @POST(Constants.loginUrl)
  Future<AuthenticationResponse> login(
    @Field("email") String email,
    @Field("password") String password,
  );

  @POST(Constants.forgotPassword)
  Future<ForgotPasswordResponse> forgotPassword(
    @Field("email") String email,
  );

  @POST(Constants.forgotPassword)
  Future<AuthenticationResponse> register(
    @Field("user_name") String username,
    @Field("email") String email,
    @Field("password") String password,
    @Field("country_mobile_code") String countryMobileCode,
    @Field("mobile") String mobile,
    @Field("profile_pic") String profilePic,
  );
}
