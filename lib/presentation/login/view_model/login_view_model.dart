import 'dart:async';

import 'package:advanced_flutter_arabic/presentation/base/base_view_model.dart';
import 'package:advanced_flutter_arabic/presentation/common/freezed_data_class.dart';

class LoginViewModel extends BaseViewModel with LoginViewModelInputs, LoginViewModelOutputs{

  final StreamController _usernameStreamController = StreamController<String>.broadcast();
  final StreamController _passwordStreamController = StreamController<String>.broadcast();

  var loginObject = LoginObject("", "");

  //inputs
  @override
  void dispose() {
    _usernameStreamController.close();
    _passwordStreamController.close();
  }

  @override
  void start() {
    // TODO: implement start
  }

  @override
  Sink get inputPassword => _passwordStreamController.sink;

  @override
  Sink get inputUsername => _usernameStreamController.sink;

  @override
  setPassword(String password) {
    inputPassword.add(password);
    loginObject = loginObject.copyWith(password: password);
  }

  @override
  setUsername(String username) {
    inputUsername.add(username);
    loginObject = loginObject.copyWith(username: username);
  }

  @override
  login() {
    // TODO: implement login
    throw UnimplementedError();
  }


  //outputs
  @override
  Stream<bool> get outIsPasswordValid => _passwordStreamController.stream.map((password) => _isPasswordValid(password));

  @override
  // TODO: implement outIsUsernameValid
  Stream<bool> get outIsUsernameValid => _usernameStreamController.stream.map((username) => _isUsernameValid(username));



  bool _isPasswordValid(String password){
    return password.isNotEmpty;
  }

  bool _isUsernameValid(String username){
    return username.isNotEmpty;
  }
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