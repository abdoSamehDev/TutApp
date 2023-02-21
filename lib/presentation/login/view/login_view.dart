import 'package:advanced_flutter_arabic/presentation/login/view_model/login_view_model.dart';
import 'package:advanced_flutter_arabic/presentation/resources/assets_manager.dart';
import 'package:advanced_flutter_arabic/presentation/resources/color_manager.dart';
import 'package:advanced_flutter_arabic/presentation/resources/strings_manager.dart';
import 'package:advanced_flutter_arabic/presentation/resources/values_manager.dart';
import 'package:flutter/material.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final LoginViewModel _viewModel = LoginViewModel(_loginUseCase);
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  _bind() {
    _viewModel.start();
    _usernameController.addListener(() {
      _viewModel.setUsername(_usernameController.text);
    });
    _passwordController.addListener(() {
      _viewModel.setUsername(_passwordController.text);
    });
  }

  @override
  void initState() {
    _bind();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }

  Widget _getContentWidget() {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.only(top: AppPadding.p100),
        color: ColorManager.white,
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
                            label: const Text(AppStrings.username),
                            hintText: AppStrings.username,
                            errorText: (snapshot.data == true)
                                ? null
                                : AppStrings.usernameError),
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
                            label: const Text(AppStrings.password),
                            hintText: AppStrings.password,
                            errorText: (snapshot.data == true)
                                ? null
                                : AppStrings.passwordError),
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
                      return ElevatedButton(
                        onPressed: () {
                          _viewModel.login()
                        },
                        child: Text(AppStrings.login),
                      );
                    },
                  ),
                ),
              ],
            ),
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