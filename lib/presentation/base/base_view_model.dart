import 'dart:async';
import 'package:advanced_flutter_arabic/presentation/common/state_renderer/state_renderer_impl.dart';
import 'package:rxdart/rxdart.dart';

// shared variables and function that will be used through any view model.
abstract class BaseViewModel extends BaseViewModelInputs
    with BaseViewModelOutputs {
  final StreamController _inputStreamController =
      BehaviorSubject<FlowState>();

  @override
  Sink get inputState => _inputStreamController.sink;

  @override
  Stream<FlowState> get outputState =>
      _inputStreamController.stream.map((flowState) => flowState);

  @override
  void dispose() {
    _inputStreamController.close();
  }
}

//Inputs: orders from View (UI) to ViewModel
abstract class BaseViewModelInputs {
  //called to start view model job
  void start();

  //called when view model dies
  void dispose();

  Sink get inputState;
}

//Outputs: changes that ViewModel will do to the View (UI)
abstract class BaseViewModelOutputs {
  Stream<FlowState> get outputState;
}