import 'dart:async';

import 'package:advanced_flutter_arabic/domain/use_case/login_use_case.dart';
import 'package:advanced_flutter_arabic/presentation/base/base_view_model.dart';
import 'package:advanced_flutter_arabic/presentation/common/freezed_data_class.dart';
import 'package:advanced_flutter_arabic/presentation/common/state_renderer/state_renderer.dart';
import 'package:advanced_flutter_arabic/presentation/common/state_renderer/state_renderer_impl.dart';

class LoginViewModel extends BaseViewModel
    with LoginViewModelInputs, LoginViewModelOutputs {
  final LoginUseCase _loginUseCase;

  LoginViewModel(this._loginUseCase);

  final StreamController _usernameStreamController =
      StreamController<String>.broadcast();
  final StreamController _passwordStreamController =
      StreamController<String>.broadcast();
  final StreamController _areAllInputsValidStreamController =
      StreamController.broadcast();

  var loginObject = LoginObject("", "");

  //inputs
  @override
  void dispose() {
    _usernameStreamController.close();
    _passwordStreamController.close();
    _areAllInputsValidStreamController.close();
    super.dispose();
  }

  @override
  void start() {
    //view model should tell view please show content state
    inputState.add(ContentState());
  }

  @override
  Sink get inputPassword => _passwordStreamController.sink;

  @override
  Sink get inputUsername => _usernameStreamController.sink;

  @override
  Sink get inputAreAllInputsValid => _areAllInputsValidStreamController.sink;

  @override
  setPassword(String password) {
    inputPassword.add(password);
    loginObject = loginObject.copyWith(password: password);
    inputAreAllInputsValid.add(null);
  }

  @override
  setUsername(String username) {
    inputUsername.add(username);
    loginObject = loginObject.copyWith(username: username);
    inputAreAllInputsValid.add(null);
  }

  @override
  login() async {
    inputState.add(LoadingState(
      stateRendererType: StateRendererType.popupLoadingState,
    ));
    (await _loginUseCase.execute(
            LoginUseCaseInput(loginObject.username, loginObject.password)))
        .fold(
            (failure) => {
                  //Failure (left)
                  inputState.add(ErrorState(
                      stateRendererType: StateRendererType.popupErrorState,
                      message: failure.message))
                },
            (data) => {
                  //Success (Right)
                  //content state
                  inputState.add(ContentState())
                  //navigate to home screen
                });
  }

  //outputs
  @override
  Stream<bool> get outIsPasswordValid => _passwordStreamController.stream
      .map((password) => _isPasswordValid(password));

  @override
  Stream<bool> get outIsUsernameValid => _usernameStreamController.stream
      .map((username) => _isUsernameValid(username));

  @override
  Stream<bool> get outputAreAllInputsValid =>
      _areAllInputsValidStreamController.stream
          .map((_) => _areAllInputsValid());

  bool _isPasswordValid(String password) {
    return password.isNotEmpty;
  }

  bool _isUsernameValid(String username) {
    return username.isNotEmpty;
  }

  bool _areAllInputsValid() {
    return _isUsernameValid(loginObject.username) &&
        _isPasswordValid(loginObject.password);
  }
}

abstract class LoginViewModelInputs {
  setUsername(String username);

  setPassword(String password);

  login();

  Sink get inputUsername;

  Sink get inputPassword;

  Sink get inputAreAllInputsValid;
}

abstract class LoginViewModelOutputs {
  Stream<bool> get outIsUsernameValid;

  Stream<bool> get outIsPasswordValid;

  Stream<bool> get outputAreAllInputsValid;
}
