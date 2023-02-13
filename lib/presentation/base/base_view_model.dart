// shared variables and function that will be used through any view model.
abstract class BaseViewModel extends BaseViewModelInputs with BaseViewModelOutputs{

}

//Inputs: orders from View (UI) to ViewModel
abstract class BaseViewModelInputs{

  //called to start view model job
  void start();

  //called when view model dies
  void dispose();

}

//Outputs: changes that ViewModel will do to the View (UI)
abstract class BaseViewModelOutputs{}