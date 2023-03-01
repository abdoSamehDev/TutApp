import 'dart:async';
import 'dart:ffi';
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

  final StreamController _homeObjectStreamController =
      BehaviorSubject<HomeObject>();
  // final StreamController _bannersStreamController =
  //     BehaviorSubject<List<BannerAd>>();
  // final StreamController _servicesStreamController =
  //     BehaviorSubject<List<Service>>();
  // final StreamController _storesStreamController =
  //     BehaviorSubject<List<Store>>();

  var homeObject = HomeObject(0, "", HomeData([], [], []));

  //inputs
  @override
  void dispose() {
    super.dispose();
    _homeObjectStreamController.close();
    // _bannersStreamController.close();
    // _servicesStreamController.close();
    // _storesStreamController.close();
  }

  @override
  void start() {
    //view model should tell view please show content state
    _getHomeData();
  }

  @override
  Sink get inputHomeObject => _homeObjectStreamController.sink;

  // @override
  // Sink get inputBanners => _bannersStreamController.sink;
  //
  // @override
  // Sink get inputServices => _servicesStreamController.sink;
  //
  // @override
  // Sink get inputStores => _storesStreamController.sink;

  @override
  _getHomeData() async {
    inputState.add(LoadingState(
      stateRendererType: StateRendererType.fullScreenLoadingState,
    ));
    (await _homeUseCase.execute(Void)).fold((failure) {
      //Failure (left)
      inputState.add(
        ErrorState(
          stateRendererType: StateRendererType.fullScreenErrorState,
          message: failure.message,
        ),
      );
    }, (homeObject) {
      //Success (Right)
      inputHomeObject.add(homeObject);
      // inputBanners.add(homeObject.data?.banners);
      // inputServices.add(homeObject.data?.services);
      // inputStores.add(homeObject.data?.stores);
      inputState.add(ContentState());
    });
  }

  //outputs
  @override
  Stream<HomeObject> get outputHomeObject =>
      _homeObjectStreamController.stream.map((homeObject) => homeObject);

  // @override
  // Stream<List<BannerAd>> get outputBanners =>
  //     _bannersStreamController.stream.map((banners) => banners);
  //
  // @override
  // Stream<List<Service>> get outputServices =>
  //     _servicesStreamController.stream.map((services) => services);
  //
  // @override
  // Stream<List<Store>> get outputStores =>
  //     _storesStreamController.stream.map((stores) => stores);
}

abstract class HomeViewModelInputs {
  _getHomeData();

  Sink get inputHomeObject;

  // Sink get inputBanners;

  // Sink get inputServices;

  // Sink get inputStores;
}

abstract class HomeViewModelOutputs {
  Stream<HomeObject> get outputHomeObject;

  // Stream<List<BannerAd>> get outputBanners;

  // Stream<List<Service>> get outputServices;

  // Stream<List<Store>> get outputStores;
}
