import 'dart:async';
import 'package:advanced_flutter_arabic/domain/model/models.dart';
import 'package:advanced_flutter_arabic/domain/use_case/home_use_case.dart';
import 'package:advanced_flutter_arabic/presentation/base/base_view_model.dart';
import 'package:advanced_flutter_arabic/presentation/common/state_renderer/state_renderer.dart';
import 'package:advanced_flutter_arabic/presentation/common/state_renderer/state_renderer_impl.dart';
import 'package:rxdart/rxdart.dart';

class HomeViewModel extends BaseViewModel
    with HomeViewModelInputs, HomeViewModelOutputs {
  final HomeUseCase _homeUseCase;

  HomeViewModel(this._homeUseCase);

  final StreamController _bannersStreamController =
      BehaviorSubject<List<Banner>>();
  final StreamController _servicesStreamController =
      BehaviorSubject<List<Service>>();
  final StreamController _storesStreamController =
      BehaviorSubject<List<Store>>();
  final StreamController __isDataValidStreamController = BehaviorSubject();

  // final StreamController isUserLoggedInSuccessfully = StreamController<bool>();

  var homeObject = HomeObject(0, "", HomeData([], [], []));

  //inputs
  @override
  void dispose() {
    super.dispose();
    _bannersStreamController.close();
    _servicesStreamController.close();
    _storesStreamController.close();
    __isDataValidStreamController.close();
    // isUserLoggedInSuccessfully.close();
  }

  @override
  void start() {
    //view model should tell view please show content state
    inputState.add(ContentState());
  }

  @override
  Sink get inputBanners => _bannersStreamController.sink;

  @override
  Sink get inputServices => _servicesStreamController.sink;

  @override
  Sink get inputStores => _storesStreamController.sink;

  @override
  Sink get inputIsDataValid => __isDataValidStreamController.sink;

  // @override
  // setPassword(String password) {
  //   inputPassword.add(password);
  //   homeObject = homeObject.copyWith(password: password);
  //   inputIsDataValid.add(null);
  // }
  //
  // @override
  // setUsername(String username) {
  //   inputUsername.add(username);
  //   homeObject = homeObject.copyWith(username: username);
  //   inputIsDataValid.add(null);
  // }

  @override
  getHomeData() async {
    inputState.add(LoadingState(
      stateRendererType: StateRendererType.popupLoadingState,
    ));
    (await _homeUseCase.execute()).fold((failure) {
      //Failure (left)
      inputState.add(
        ErrorState(
          stateRendererType: StateRendererType.popupErrorState,
          message: failure.message,
        ),
      );
    }, (data) {
      //Success (Right)
      // inputState.add(
      //   SuccessState(
      //     message: data.message,
      //   ),
      // );
      //navigate to home screen
      // isUserLoggedInSuccessfully.add(true);
    });
  }

  //outputs
  @override
  Stream<List<Banner>> get outputBanners =>
      _bannersStreamController.stream.map((banners) => banners);

  @override
  Stream<List<Service>> get outputServices =>
      _servicesStreamController.stream.map((services) => services);

  @override
  Stream<List<Store>> get outputStores =>
      _storesStreamController.stream.map((stores) => stores);

  @override
  Stream<bool> get outputIsDataValid => __isDataValidStreamController.stream
      .map((_) => _isDataValid(homeObject.data));

  bool _isDataValid(HomeData? data) {
    return data != null;
  }

// bool _areAllInputsValid() {
//   return _isDataValid(homeObject.data);
// }
}

abstract class HomeViewModelInputs {
  // setUsername(String username);
  //
  // setPassword(String password);

  getHomeData();

  // Sink get inputUsername;
  //
  // Sink get inputPassword;

  Sink get inputBanners;

  Sink get inputServices;

  Sink get inputStores;

  Sink get inputIsDataValid;
}

abstract class HomeViewModelOutputs {
  // Stream<bool> get outIsUsernameValid;
  //
  // Stream<bool> get outIsPasswordValid;

  Stream<List<Banner>> get outputBanners;

  Stream<List<Service>> get outputServices;

  Stream<List<Store>> get outputStores;

  Stream<bool> get outputIsDataValid;
}
