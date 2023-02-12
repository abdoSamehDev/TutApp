// shared variables and function that will be used through any view model.
abstract class BaseViewModel{

}

abstract class BaseViewModelInputs{

  //called to start view model job
  void start();

  //called when view model dies
  void dispose();

}

abstract class BaseViewModelOutputs{}