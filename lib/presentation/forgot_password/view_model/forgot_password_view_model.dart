import 'dart:async';
import 'package:advanced_flutter_arabic/app/functions.dart';
import 'package:advanced_flutter_arabic/domain/use_case/forgot_password_use_case.dart';
import 'package:advanced_flutter_arabic/presentation/base/base_view_model.dart';
import 'package:advanced_flutter_arabic/presentation/common/state_renderer/state_renderer.dart';
import 'package:advanced_flutter_arabic/presentation/common/state_renderer/state_renderer_impl.dart';

class ForgotPasswordViewModel extends BaseViewModel
    with ForgotPasswordViewModelInputs, ForgotPasswordViewModelOutputs {
  final ForgotPasswordUseCase _forgotPasswordUseCase;

  ForgotPasswordViewModel(this._forgotPasswordUseCase);

  final StreamController _emailStreamController =
      StreamController<String>.broadcast();
  final StreamController _isEmailValidStreamController =
      StreamController.broadcast();
  final StreamController isResetEmailSent = StreamController<bool>();

  String email = "";

  //inputs
  @override
  void dispose() {
    super.dispose();
    _emailStreamController.close();
    _isEmailValidStreamController.close();
    isResetEmailSent.close();
  }

  @override
  void start() {
    //view model should tell view please show content state
    inputState.add(ContentState());
  }

  @override
  Sink get inputEmail => _emailStreamController.sink;

  @override
  Sink get inputIsEmailValid => _isEmailValidStreamController.sink;

  @override
  setEmail(String email) {
    inputEmail.add(email);
    this.email = email;
    inputIsEmailValid.add(null);
  }

  @override
  sendResetPasswordEmail() async {
    inputState.add(LoadingState(
      stateRendererType: StateRendererType.popupLoadingState,
    ));
    (await _forgotPasswordUseCase.execute(email)).fold((failure) {
      //Failure (left)
      inputState.add(
        ErrorState(
          stateRendererType: StateRendererType.popupErrorState,
          message: failure.message,
        ),
      );
    }, (success) {
      //Success (Right)
      inputState.add(
        SuccessState(
          message: success.message,
        ),
      );
      //navigate back to login screen
      isResetEmailSent.add(true);
    });
  }

  //outputs
  @override
  Stream<bool> get outIsEmailValid =>
      _emailStreamController.stream.map((email) => _isEmailValid(email));

  bool _isEmailValid(String email) {
    return isEmailValid(email);
  }
}

abstract class ForgotPasswordViewModelInputs {
  setEmail(String email);

  sendResetPasswordEmail();

  Sink get inputEmail;

  Sink get inputIsEmailValid;
}

abstract class ForgotPasswordViewModelOutputs {
  Stream<bool> get outIsEmailValid;
}
