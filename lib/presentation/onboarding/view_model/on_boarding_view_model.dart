import 'dart:async';

import 'package:advanced_flutter_arabic/domain/model/models.dart';
import 'package:advanced_flutter_arabic/presentation/base/base_view_model.dart';
import 'package:easy_localization/easy_localization.dart';

import '../../resources/assets_manager.dart';
import '../../resources/strings_manager.dart';

class OnBoardingViewModel extends BaseViewModel with OnBoardingViewModelInputs, OnBoardingViewModelOutputs{
  final StreamController _streamController = StreamController<SliderViewObject>();
  int _currentIndex = 0;
  late final List<SliderObject> _list;

  @override
  void dispose() {
    _streamController.close();
    super.dispose();
  }

  @override
  void start() {
    _list = _getSliderData();
    _postDataToView();
  }

  @override
  int goNext() {
    int nextIndex = ++_currentIndex;
    if (nextIndex == _list.length) {
      nextIndex = 0;
    }
    return nextIndex;
  }

  @override
  int goPrevious() {
    int previousIndex = --_currentIndex;
    if (previousIndex == -1) {
      previousIndex = _list.length - 1;
    }
    return previousIndex;
  }

  @override
  void onPageChanged(int index) {
    _currentIndex = index;
    _postDataToView();
  }

  @override
  Sink get inputSliderViewObject => _streamController.sink;

  //OnBoarding ViewModel outputs
  @override
  Stream get outputSliderViewObject => _streamController.stream.map((sliderViewObject) => sliderViewObject);


  //onBoarding private functions
  void _postDataToView(){
    inputSliderViewObject.add(SliderViewObject(_list[_currentIndex], _currentIndex, _list.length));
  }

  List<SliderObject> _getSliderData() => [
    SliderObject(
      AppStrings.onBoardingTitle1.tr(),
      AppStrings.onBoardingBody1.tr(),
      ImageAssets.onBoarding1,
    ),
    SliderObject(
      AppStrings.onBoardingTitle2.tr(),
      AppStrings.onBoardingBody2.tr(),
      ImageAssets.onBoarding2,
    ),
    SliderObject(
      AppStrings.onBoardingTitle3.tr(),
      AppStrings.onBoardingBody3.tr(),
      ImageAssets.onBoarding3,
    ),
    SliderObject(
      AppStrings.onBoardingTitle4.tr(),
      AppStrings.onBoardingBody4.tr(),
      ImageAssets.onBoarding4,
    ),
  ];
}

abstract class OnBoardingViewModelInputs{

  void goNext();
  void goPrevious();
  void onPageChanged(int index);

  // stream controller input
  Sink get inputSliderViewObject;

}

abstract class OnBoardingViewModelOutputs{
  // stream controller outputs
  Stream get outputSliderViewObject;
}