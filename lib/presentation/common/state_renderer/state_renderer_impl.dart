import 'package:advanced_flutter_arabic/app/constants.dart';
import 'package:advanced_flutter_arabic/presentation/common/state_renderer/state_renderer.dart';
import 'package:advanced_flutter_arabic/presentation/resources/strings_manager.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

abstract class FlowState {
  StateRendererType getStateRendererType();

  String getMessage();
}

//loading state (popup & full screen)
class LoadingState extends FlowState {
  StateRendererType stateRendererType;
  String? message;

  LoadingState(
      {required this.stateRendererType, this.message = AppStrings.loading});

  @override
  String getMessage() => message ?? AppStrings.loading.tr();

  @override
  StateRendererType getStateRendererType() => stateRendererType;
}

//error state (popup & full screen)
class ErrorState extends FlowState {
  StateRendererType stateRendererType;
  String title;
  String message;

  ErrorState({
    required this.stateRendererType,
    this.title = Constants.empty,
    required this.message,
  });

  @override
  String getMessage() => message;

  @override
  StateRendererType getStateRendererType() => stateRendererType;
}

//success state (popup)
class SuccessState extends FlowState {
  String title = AppStrings.success.tr();
  String message;

  SuccessState({
    required this.message,
  });

  @override
  String getMessage() => message;

  @override
  StateRendererType getStateRendererType() => StateRendererType.popupSuccessState;
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
            showPopup(context, getStateRendererType(), AppStrings.loading.tr());
            //show ui of the screen
            return screenContentWidget;
          } else {
            //full screen loading state
            return StateRenderer(
              stateRendererType: getStateRendererType(),
              retryActionFunction: retryActionFunction,
              message: AppStrings.loading.tr(),
            );
          }
        }
      case SuccessState:
        {
          dismissDialog(context);
            //show popup
            showPopup(context, getStateRendererType(), getMessage(), title: AppStrings.success.tr());
            //show ui of the screen
            return screenContentWidget;
        }
      case ErrorState:
        {
          dismissDialog(context);
          if (getStateRendererType() == StateRendererType.popupErrorState) {
            //show popup
            showPopup(context, getStateRendererType(), getMessage(), title: AppStrings.error.tr());
            //show ui of the screen
            return screenContentWidget;
          } else {
            //full screen error state
            return StateRenderer(
              stateRendererType: getStateRendererType(),
              title: AppStrings.error.tr(),
              retryActionFunction: retryActionFunction,
              message: getMessage(),
            );
          }
        }
      case EmptyState:
        {
          dismissDialog(context);
          return StateRenderer(
            stateRendererType: getStateRendererType(),
            retryActionFunction: () {},
            message: getMessage(),
          );
        }
      case ContentState:
        {
          dismissDialog(context);
          return screenContentWidget;
        }
      default:
        {
          dismissDialog(context);
          return screenContentWidget;
        }
    }
  }

  bool _isCurrentDialogShowing(BuildContext context) {
    return ModalRoute.of(context)?.isCurrent != true;
  }

  dismissDialog(BuildContext context) {
    if (_isCurrentDialogShowing(context)) {
      Navigator.pop(context);
    }
  }

  void showPopup(BuildContext context, StateRendererType stateRendererType,
      String message, {String title = Constants.empty}) {
    WidgetsBinding.instance.addPostFrameCallback((_) => showDialog(
        context: context,
        builder: (BuildContext context) => StateRenderer(
            stateRendererType: stateRendererType,
            title: title,
            message: message,
            retryActionFunction: () {})));
  }
}
