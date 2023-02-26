import 'package:advanced_flutter_arabic/data/network/app_api.dart';
import 'package:advanced_flutter_arabic/data/network/requests.dart';

import '../responses/responses.dart';

abstract class RemoteDataSource {
  Future<AuthenticationResponse> login(LoginRequest loginRequest);

  Future<ForgotPasswordResponse> forgotPassword(String email);

  Future<AuthenticationResponse> register(RegisterRequest registerRequest);
}

class RemoteDataSourceImpl implements RemoteDataSource {
  final AppServiceClient _appServiceClient;

  RemoteDataSourceImpl(this._appServiceClient);

  @override
  Future<AuthenticationResponse> login(LoginRequest loginRequest) async {
    return await _appServiceClient.login(
        loginRequest.email, loginRequest.password);
  }

  @override
  Future<ForgotPasswordResponse> forgotPassword(String email) async {
    return await _appServiceClient.forgotPassword(email);
  }

  @override
  Future<AuthenticationResponse> register(RegisterRequest registerRequest) async {
    return await _appServiceClient.register(
      registerRequest.username,
      registerRequest.email,
      registerRequest.password,
      registerRequest.countryMobileCode,
      registerRequest.mobile,
      registerRequest.profilePic,
    );
  }
}
