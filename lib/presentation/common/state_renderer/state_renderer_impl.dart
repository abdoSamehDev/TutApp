import 'package:advanced_flutter_arabic/app/constants.dart';
import 'package:advanced_flutter_arabic/presentation/common/state_renderer/state_renderer.dart';
import 'package:advanced_flutter_arabic/presentation/resources/strings_manager.dart';
import 'package:flutter/material.dart';

abstract class FlowState {
  StateRendererType getStateRendererType();

  String getMessage();
}

//loading state (popup & full screen)
class LoadingState extends FlowState {
  StateRendererType stateRendererType;
  String message;

  LoadingState(
      {required this.stateRendererType, this.message = AppStrings.loading});

  @override
  String getMessage() => message;

  @override
  StateRendererType getStateRendererType() => stateRendererType;
}

//error state (popup & full screen)
class ErrorState extends FlowState {
  StateRendererType stateRendererType;
  String message;

  ErrorState({
    required this.stateRendererType,
    required this.message,
  });

  @override
  String getMessage() => message;

  @override
  StateRendererType getStateRendererType() => stateRendererType;
}

//content state
class ContentState extends FlowState {
  @override
  String getMessage() => Constants.empty;

  @override
  StateRendererType getStateRendererType() => StateRendererType.contentState;
}

//empty state
class EmptyState extends FlowState {
  String message;

  EmptyState(this.message);

  @override
  String getMessage() => message;

  @override
  StateRendererType getStateRendererType() =>
      StateRendererType.fullScreenEmptyState;
}

extension FlowStateExtension on FlowState {
  Widget getScreenWidget(BuildContext context, Widget screenContentWidget,
      Function retryActionFunction) {
    switch (runtimeType) {
      case LoadingState:
        {
          if (getStateRendererType() == StateRendererType.popupLoadingState) {
            //show popup
            showPopup(context, getStateRendererType(), getMessage());
            //show ui of the screen
            return screenContentWidget;
          } else {
            //full screen loading state
            return StateRenderer(
              stateRendererType: getStateRendererType(),
              retryActionFunction: retryActionFunction,
              message: getMessage(),
            );
          }
        }
      case ErrorState:
        {
          if (getStateRendererType() == StateRendererType.popupErrorState) {
            //show popup
            showPopup(context, getStateRendererType(), getMessage());
            //show ui of the screen
            return screenContentWidget;
          } else {
            //full screen loading state
            return StateRenderer(
              stateRendererType: getStateRendererType(),
              retryActionFunction: retryActionFunction,
              message: getMessage(),
            );
          }
        }
      case EmptyState:
        {
          return StateRenderer(
            stateRendererType: getStateRendererType(),
            retryActionFunction: (){},
            message: getMessage(),
          );
        }
      case ContentState:
        {
          return screenContentWidget;
        }
      default:
        {
          return screenContentWidget;
        }
    }
  }

  void showPopup(BuildContext context, StateRendererType stateRendererType,
      String message) {
    showDialog(
        context: context,
        builder: (context) => StateRenderer(
              stateRendererType: stateRendererType,
              retryActionFunction: () {},
              message: message,
            ));
  }
}
