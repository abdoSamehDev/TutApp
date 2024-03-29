import 'package:advanced_flutter_arabic/app/app_prefs.dart';
import 'package:advanced_flutter_arabic/app/di.dart';
import 'package:advanced_flutter_arabic/presentation/common/state_renderer/state_renderer_impl.dart';
import 'package:advanced_flutter_arabic/presentation/login/view_model/login_view_model.dart';
import 'package:advanced_flutter_arabic/presentation/resources/assets_manager.dart';
import 'package:advanced_flutter_arabic/presentation/resources/color_manager.dart';
import 'package:advanced_flutter_arabic/presentation/resources/strings_manager.dart';
import 'package:advanced_flutter_arabic/presentation/resources/values_manager.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../resources/routes_manager.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final LoginViewModel _viewModel = instance<LoginViewModel>();
  final AppPreferences _preferences = instance<AppPreferences>();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  _bind() {
    _viewModel.start();
    _usernameController.addListener(() {
      _viewModel.setUsername(_usernameController.text);
    });
    _passwordController.addListener(() {
      _viewModel.setPassword(_passwordController.text);
    });
    _viewModel.isUserLoggedInSuccessfully.stream.listen((isLoggedIn) {
      if (isLoggedIn) {
        WidgetsBinding.instance.addPostFrameCallback(
          (_) {
            _preferences.setUserLoggedIn();
            Navigator.pushReplacementNamed(context, Routes.homeRoute);
          },
        );
      }
    });
  }

  @override
  void initState() {
    _bind();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.white,
      body: StreamBuilder<FlowState>(
          stream: _viewModel.outputState,
          builder: (context, snapshot) {
            return snapshot.data
                    ?.getScreenWidget(context, _getContentWidget(), () {}) ??
                _getContentWidget();
          }),
    );
  }

  Widget _getContentWidget() {
    return Container(
      padding: const EdgeInsets.only(top: AppPadding.p100),
      child: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              const Center(
                child: Image(
                  image: AssetImage(ImageAssets.splashLogo),
                ),
              ),
              const SizedBox(
                height: AppSize.s25,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppPadding.p20,
                ),
                child: StreamBuilder<bool>(
                  stream: _viewModel.outIsUsernameValid,
                  builder: (context, snapshot) {
                    return TextFormField(
                      keyboardType: TextInputType.text,
                      controller: _usernameController,
                      decoration: InputDecoration(
                          label:  Text(AppStrings.username.tr()),
                          hintText: AppStrings.username.tr(),
                          errorText: (snapshot.data ?? true)
                              ? null
                              : AppStrings.usernameError.tr()),
                    );
                  },
                ),
              ),
              const SizedBox(
                height: AppSize.s14,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppPadding.p20,
                ),
                child: StreamBuilder<bool>(
                  stream: _viewModel.outIsPasswordValid,
                  builder: (context, snapshot) {
                    return TextFormField(
                      keyboardType: TextInputType.visiblePassword,
                      controller: _passwordController,
                      decoration: InputDecoration(
                          label:  Text(AppStrings.password.tr()),
                          hintText: AppStrings.password.tr(),
                          errorText: (snapshot.data ?? true)
                              ? null
                              : AppStrings.passwordError.tr()),
                    );
                  },
                ),
              ),
              const SizedBox(
                height: AppSize.s14,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppPadding.p20,
                ),
                child: StreamBuilder<bool>(
                  stream: _viewModel.outputAreAllInputsValid,
                  builder: (context, snapshot) {
                    return SizedBox(
                      width: double.infinity,
                      height: AppSize.s40,
                      child: ElevatedButton(
                        onPressed: (snapshot.data ?? false)
                            ? () {
                                _viewModel.login();
                              }
                            : null,
                        child:  Text(
                          AppStrings.login.tr(),
                        ),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(
                height: AppSize.s14,
              ),
              Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppPadding.p20,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton(
                        onPressed: () {
                          Navigator.pushNamed(
                              context, Routes.forgotPasswordRoute);
                        },
                        child: Text(
                          AppStrings.forgetPassword.tr(),
                          style: Theme.of(context).textTheme.labelMedium,
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pushNamed(context, Routes.registerRoute);
                        },
                        child: Text(
                          AppStrings.registerText.tr(),
                          style: Theme.of(context).textTheme.labelMedium,
                        ),
                      ),
                    ],
                  )),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _viewModel.dispose();
    super.dispose();
  }
}
