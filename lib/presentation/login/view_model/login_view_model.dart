import 'package:advanced_flutter_arabic/presentation/base/base_view_model.dart';

class LoginViewModel extends BaseViewModel with LoginViewModelInputs, LoginViewModelOutputs{
  //inputs
  @override
  void dispose() {
    // TODO: implement dispose
  }

  @override
  void start() {
    // TODO: implement start
  }

  @override
  // TODO: implement inputPassword
  Sink get inputPassword => throw UnimplementedError();

  @override
  // TODO: implement inputUsername
  Sink get inputUsername => throw UnimplementedError();

  @override
  setPassword(String password) {
    // TODO: implement setPassword
    throw UnimplementedError();
  }

  @override
  setUsername(String username) {
    // TODO: implement setUsername
    throw UnimplementedError();
  }

  @override
  login() {
    // TODO: implement login
    throw UnimplementedError();
  }


  //outputs
  @override
  // TODO: implement outIsPasswordValid
  Stream<bool> get outIsPasswordValid => throw UnimplementedError();

  @override
  // TODO: implement outIsUsernameValid
  Stream<bool> get outIsUsernameValid => throw UnimplementedError();


}

abstract class LoginViewModelInputs{
  setUsername(String username);
  setPassword(String password);
  login();

  Sink get inputUsername;
  Sink get inputPassword;
}

abstract class LoginViewModelOutputs{
  Stream<bool> get outIsUsernameValid;
  Stream<bool> get outIsPasswordValid;
}