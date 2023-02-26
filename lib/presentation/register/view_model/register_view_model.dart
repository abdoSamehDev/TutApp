import 'dart:async';
import 'dart:io';
import 'package:advanced_flutter_arabic/app/functions.dart';
import 'package:advanced_flutter_arabic/domain/use_case/register_use_case.dart';
import 'package:advanced_flutter_arabic/presentation/base/base_view_model.dart';
import 'package:advanced_flutter_arabic/presentation/common/freezed_data_class.dart';
import 'package:advanced_flutter_arabic/presentation/common/state_renderer/state_renderer.dart';
import 'package:advanced_flutter_arabic/presentation/common/state_renderer/state_renderer_impl.dart';
import 'package:advanced_flutter_arabic/presentation/resources/strings_manager.dart';

class RegisterViewModel extends BaseViewModel
    with RegisterViewModelInputs, RegisterViewModelOutputs {
  final RegisterUseCase _registerUseCase;

  RegisterViewModel(this._registerUseCase);

  final StreamController _usernameStreamController =
      StreamController<String>.broadcast();
  final StreamController _emailStreamController =
      StreamController<String>.broadcast();
  final StreamController _passwordStreamController =
      StreamController<String>.broadcast();
  final StreamController _mobileStreamController =
      StreamController<String>.broadcast();
  final StreamController _profilePicStreamController =
      StreamController<File>.broadcast();
  final StreamController _areAllInputsValidStreamController =
      StreamController.broadcast();
  final StreamController isUserLoggedInSuccessfully = StreamController<bool>();

  var registerObject = RegisterObject(
    "",
    "",
    "",
    "",
    "",
    "",
  );

  //inputs
  @override
  void dispose() {
    super.dispose();
    _usernameStreamController.close();
    _emailStreamController.close();
    _passwordStreamController.close();
    _mobileStreamController.close();
    _profilePicStreamController.close();
    _areAllInputsValidStreamController.close();
    isUserLoggedInSuccessfully.close();
  }

  @override
  void start() {
    //view model should tell view please show content state
    inputState.add(ContentState());
  }

  @override
  Sink get inputUsername => _usernameStreamController.sink;

  @override
  Sink get inputEmail => _emailStreamController.sink;

  @override
  Sink get inputPassword => _passwordStreamController.sink;

  @override
  Sink get inputMobile => _mobileStreamController.sink;

  @override
  Sink get inputProfilePic => _profilePicStreamController.sink;

  @override
  Sink get inputAreAllInputsValid => _areAllInputsValidStreamController.sink;











  @override
  setUsername(String username) {
    inputUsername.add(username);
    registerObject = registerObject.copyWith(username: username);
    inputAreAllInputsValid.add(null);
  }

  @override
  setEmail(String email) {
    inputEmail.add(email);
    registerObject = registerObject.copyWith(email: email);
    inputAreAllInputsValid.add(null);
  }

  @override
  setPassword(String password) {
    inputPassword.add(password);
    registerObject = registerObject.copyWith(password: password);
    inputAreAllInputsValid.add(null);
  }

  @override
  setCountryMobileCode(String countryMobileCode) {
    if(countryMobileCode.isNotEmpty){
      registerObject =registerObject.copyWith(countryMobileCode: countryMobileCode);
    }else{
      registerObject =registerObject.copyWith(countryMobileCode: "");
    }
    inputAreAllInputsValid.add(null);
  }

  @override
  setMobile(String mobile) {
    inputMobile.add(mobile);
    registerObject = registerObject.copyWith(mobile: mobile);
    inputAreAllInputsValid.add(null);
  }

  @override
  setProfilePic(File picture) {
    inputProfilePic.add(picture);
    registerObject = registerObject.copyWith(profilePic: picture.path);
    inputAreAllInputsValid.add(null);
  }

  @override
  register() async {
    inputState.add(LoadingState(
      stateRendererType: StateRendererType.popupLoadingState,
    ));
    (await _registerUseCase.execute(RegisterUseCaseInput(
      registerObject.username,
      registerObject.email,
      registerObject.password,
      registerObject.countryMobileCode,
      registerObject.mobile,
      registerObject.profilePic,
    )))
        .fold((failure) {
      //Failure (left)
      inputState.add(
        ErrorState(
          stateRendererType: StateRendererType.popupErrorState,
          message: failure.message,
        ),
      );
    }, (data) {
      //Success (Right)
      inputState.add(
        SuccessState(
          message: data.message,
        ),
      );
      //navigate to home screen
      isUserLoggedInSuccessfully.add(true);
    });
  }

  //outputs
  @override
  Stream<bool> get outIsUsernameValid => _usernameStreamController.stream
      .map((username) => _isUsernameValid(username));

  @override
  Stream<String?> get outErrorUsername => outIsUsernameValid.map(
      (isUsernameValid) => isUsernameValid ? null : AppStrings.invalidUsername);

  @override
  Stream<bool> get outIsEmailValid =>
      _emailStreamController.stream.map((email) => _isEmailValid(email));

  @override
  Stream<String?> get outErrorEmail => outIsEmailValid
      .map((isEmailValid) => isEmailValid ? null : AppStrings.invalidEmail);

  @override
  Stream<bool> get outIsPasswordValid => _passwordStreamController.stream
      .map((password) => _isPasswordValid(password));

  @override
  Stream<String?> get outErrorPassword => outIsPasswordValid.map(
      (isPasswordValid) => isPasswordValid ? null : AppStrings.invalidPassword);

  @override
  Stream<bool> get outIsMobileValid =>
      _mobileStreamController.stream.map((mobile) => _isMobileValid(mobile));

  @override
  Stream<String?> get outErrorMobile => outIsMobileValid
      .map((isMobileValid) => isMobileValid ? null : AppStrings.invalidMobile);

  @override
  Stream<File> get outIsProfilePicValid =>
      _profilePicStreamController.stream.map((file) => file);

  @override
  Stream<bool> get outputAreAllInputsValid =>
      _areAllInputsValidStreamController.stream
          .map((_) => _areAllInputsValid());

  //private functions
  bool _isPasswordValid(String password) {
    return password.length >= 6;
  }

  bool _isUsernameValid(String username) {
    return username.length >= 4;
  }

  bool _isMobileValid(String mobile) {
    return mobile.length >= 10;
  }

  bool _isEmailValid(String email) {
    return isEmailValid(email);
  }

  bool _isProfilePictureValid(String picture) {
    return picture.isNotEmpty;
  }

  bool _areAllInputsValid() {
    return _isUsernameValid(registerObject.username) &&
        _isPasswordValid(registerObject.password) && _isMobileValid(registerObject.mobile) && _isEmailValid(registerObject.email) && _isProfilePictureValid(registerObject.profilePic);
  }
}

abstract class RegisterViewModelInputs {
  setUsername(String username);

  setEmail(String email);

  setPassword(String password);

  setCountryMobileCode(String countryMobileCode);

  setMobile(String mobile);

  setProfilePic(File picture);

  register();

  Sink get inputUsername;

  Sink get inputEmail;

  Sink get inputPassword;

  Sink get inputMobile;

  Sink get inputProfilePic;

  Sink get inputAreAllInputsValid;
}

abstract class RegisterViewModelOutputs {
  Stream<bool> get outIsUsernameValid;

  Stream<String?> get outErrorUsername;

  Stream<bool> get outIsEmailValid;

  Stream<String?> get outErrorEmail;

  Stream<bool> get outIsPasswordValid;

  Stream<String?> get outErrorPassword;

  Stream<bool> get outIsMobileValid;

  Stream<String?> get outErrorMobile;

  Stream<File> get outIsProfilePicValid;

  Stream<bool> get outputAreAllInputsValid;
}
