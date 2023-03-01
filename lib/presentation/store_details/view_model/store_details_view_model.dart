import 'dart:async';
import 'dart:ffi';
import 'package:advanced_flutter_arabic/domain/model/models.dart';
import 'package:advanced_flutter_arabic/domain/use_case/store_details_use_case.dart';
import 'package:advanced_flutter_arabic/presentation/base/base_view_model.dart';
import 'package:advanced_flutter_arabic/presentation/common/state_renderer/state_renderer.dart';
import 'package:advanced_flutter_arabic/presentation/common/state_renderer/state_renderer_impl.dart';
import 'package:rxdart/rxdart.dart';

class StoreDetailsViewModel extends BaseViewModel
    with StoreDetailsViewModelInputs, StoreDetailsViewModelOutputs {
  final StoreDetailsUseCase _storeDetailsUseCase;

  StoreDetailsViewModel(this._storeDetailsUseCase);

  final StreamController _storeDetailsStreamController =
      BehaviorSubject<StoreDetails>();

  var storeDetails = StoreDetails(0, "", "", 1, "", "", "", "");

  //inputs
  @override
  void dispose() {
    super.dispose();
    _storeDetailsStreamController.close();
  }

  @override
  void start() {
    //view model should tell view please show content state
    _getStoreDetailsData();
  }

  @override
  Sink get inputStoreDetails => _storeDetailsStreamController.sink;

  @override
  _getStoreDetailsData() async {
    inputState.add(LoadingState(
      stateRendererType: StateRendererType.fullScreenLoadingState,
    ));
    (await _storeDetailsUseCase.execute(Void)).fold((failure) {
      //Failure (left)
      inputState.add(
        ErrorState(
          stateRendererType: StateRendererType.fullScreenErrorState,
          message: failure.message,
        ),
      );
    }, (storeDetails) {
      //Success (Right)
      inputStoreDetails.add(storeDetails);
      inputState.add(ContentState());
    });
  }

  //outputs
  @override
  Stream<StoreDetails> get outputStoreDetails =>
      _storeDetailsStreamController.stream.map((storeDetails) => storeDetails);
}

abstract class StoreDetailsViewModelInputs {
  _getStoreDetailsData();

  Sink get inputStoreDetails;
}

abstract class StoreDetailsViewModelOutputs {
  Stream<StoreDetails> get outputStoreDetails;
}
