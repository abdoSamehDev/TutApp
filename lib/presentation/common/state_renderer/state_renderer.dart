import 'package:advanced_flutter_arabic/app/constants.dart';
import 'package:advanced_flutter_arabic/presentation/resources/assets_manager.dart';
import 'package:advanced_flutter_arabic/presentation/resources/color_manager.dart';
import 'package:advanced_flutter_arabic/presentation/resources/font_manager.dart';
import 'package:advanced_flutter_arabic/presentation/resources/strings_manager.dart';
import 'package:advanced_flutter_arabic/presentation/resources/styles_manager.dart';
import 'package:advanced_flutter_arabic/presentation/resources/values_manager.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

enum StateRendererType {
  //POPUP STATES
  popupLoadingState,
  popupErrorState,

  //FULL SCREEN STATES
  fullScreenLoadingState,
  fullScreenErrorState,
  fullScreenEmptyState,

  //SUCCESS
  popupSuccessState,

  //GENERAL
  contentState
}

// ignore: must_be_immutable
class StateRenderer extends StatelessWidget {
  StateRendererType stateRendererType;
  String message;
  String title;
  Function retryActionFunction;

  StateRenderer({
    required this.stateRendererType,
    this.message = AppStrings.loading,
    this.title = Constants.empty,
    required this.retryActionFunction,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return _getStateWidget(context);
  }

  Widget _getStateWidget(context) {
    switch (stateRendererType) {
      case StateRendererType.popupLoadingState:
        return _getPopupDialog([_getAnimatedImage(JsonAssets.loading)]);
      case StateRendererType.popupErrorState:
        return _getPopupDialog([
          _getAnimatedImage(JsonAssets.error),
          _getTitle(title),
          _getMessage(message),
          _getRetryButton(AppStrings.ok, context),
        ]);
      case StateRendererType.popupSuccessState:
        return _getPopupDialog([
          _getAnimatedImage(JsonAssets.success),
          _getTitle(title),
          _getMessage(message),
          _getRetryButton(AppStrings.ok, context),
        ]);
      case StateRendererType.fullScreenLoadingState:
        return _getItemsColumn([
          _getAnimatedImage(JsonAssets.loading),
          _getMessage(message),
        ]);
      case StateRendererType.fullScreenErrorState:
        return _getItemsColumn([
          _getAnimatedImage(JsonAssets.error),
          _getMessage(message),
          _getRetryButton(AppStrings.retryAgain, context),
        ]);
      case StateRendererType.fullScreenEmptyState:
        return _getItemsColumn([
          _getAnimatedImage(JsonAssets.empty),
          _getMessage(message),
        ]);
      case StateRendererType.contentState:
        return Container();
      default:
        return Container();
    }
  }

  Widget _getItemsColumn(List<Widget> children) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: children,
    );
  }

  Widget _getAnimatedImage(String animationName) {
    return SizedBox(
        height: AppSize.s100,
        width: AppSize.s100,
        child: Lottie.asset(animationName));
  }

  Widget _getTitle(String title) {
    return Padding(
      padding: const EdgeInsets.all(AppPadding.p8),
      child: Text(
        title,
        style: getSemiBoldStyle(
          color: ColorManager.black,
          fontSize: FontSize.s20,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget _getMessage(String message) {
    return Padding(
      padding: const EdgeInsets.all(AppPadding.p8),
      child: Text(
        message,
        style: getRegularStyle(
          color: ColorManager.black,
          fontSize: FontSize.s18,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget _getRetryButton(String buttonLabel, context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppPadding.p18),
        child: SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () {
              if (stateRendererType == StateRendererType.fullScreenErrorState) {
                retryActionFunction.call();
              } else {
                Navigator.pop(context);
              }
            },
            child: Text(
              buttonLabel,
            ),
          ),
        ),
      ),
    );
  }

  Widget _getPopupDialog(List<Widget> children) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppSize.s14),
      ),
      elevation: AppSize.s1_5,
      backgroundColor: ColorManager.white,
      child: _getDialogContent(children),
    );
  }

  Widget _getDialogContent(List<Widget> children) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: children,
    );
  }
}
