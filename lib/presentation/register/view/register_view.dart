import 'dart:io';

import 'package:advanced_flutter_arabic/app/app_prefs.dart';
import 'package:advanced_flutter_arabic/app/constants.dart';
import 'package:advanced_flutter_arabic/app/di.dart';
import 'package:advanced_flutter_arabic/presentation/common/state_renderer/state_renderer_impl.dart';
import 'package:advanced_flutter_arabic/presentation/register/view_model/register_view_model.dart';
import 'package:advanced_flutter_arabic/presentation/resources/assets_manager.dart';
import 'package:advanced_flutter_arabic/presentation/resources/color_manager.dart';
import 'package:advanced_flutter_arabic/presentation/resources/strings_manager.dart';
import 'package:advanced_flutter_arabic/presentation/resources/values_manager.dart';
import 'package:country_list_pick/country_list_pick.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../resources/routes_manager.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({Key? key}) : super(key: key);

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  final RegisterViewModel _viewModel = instance<RegisterViewModel>();
  final ImagePicker _imagePicker = instance<ImagePicker>();
  final AppPreferences _preferences = instance<AppPreferences>();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _mobileController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  _bind() {
    _viewModel.start();
    _usernameController.addListener(() {
      _viewModel.setUsername(_usernameController.text);
    });
    _passwordController.addListener(() {
      _viewModel.setPassword(_passwordController.text);
    });
    _emailController.addListener(() {
      _viewModel.setEmail(_emailController.text);
    });
    _mobileController.addListener(() {
      _viewModel.setMobile(_mobileController.text);
    });
    _viewModel.isUserRegisteredSuccessfully.stream.listen((isRegistered) {
      if (isRegistered) {
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
      appBar: AppBar(
        elevation: AppSize.s0,
        backgroundColor: ColorManager.white,
        iconTheme: IconThemeData(color: ColorManager.primary),
      ),
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
    return SingleChildScrollView(
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
              child: StreamBuilder<String?>(
                stream: _viewModel.outErrorUsername,
                builder: (context, snapshot) {
                  return TextFormField(
                    keyboardType: TextInputType.text,
                    controller: _usernameController,
                    decoration: InputDecoration(
                        label: const Text(AppStrings.username),
                        hintText: AppStrings.username,
                        errorText: snapshot.data),
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
              child: StreamBuilder<String?>(
                stream: _viewModel.outErrorEmail,
                builder: (context, snapshot) {
                  return TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    controller: _emailController,
                    decoration: InputDecoration(
                        label: const Text(AppStrings.email),
                        hintText: AppStrings.emailHint,
                        errorText: snapshot.data),
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
              child: StreamBuilder<String?>(
                stream: _viewModel.outErrorPassword,
                builder: (context, snapshot) {
                  return TextFormField(
                    keyboardType: TextInputType.visiblePassword,
                    controller: _passwordController,
                    decoration: InputDecoration(
                        label: const Text(AppStrings.password),
                        hintText: AppStrings.password,
                        errorText: snapshot.data),
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
                children: [
                  CountryListPick(
                    theme: CountryTheme(
                        isShowCode: false,
                        isShowTitle: false,
                        isDownIcon: false),
                    onChanged: (CountryCode? country) {
                      _viewModel.setCountryMobileCode(
                          country?.dialCode ?? Constants.empty);
                      if (kDebugMode) {
                        print("${country?.dialCode}" "${country?.name}");
                      }
                    },
                    initialSelection: "+20",
                  ),
                  Expanded(
                    child: StreamBuilder<String?>(
                      stream: _viewModel.outErrorMobile,
                      builder: (context, snapshot) {
                        return TextFormField(
                          keyboardType: TextInputType.phone,
                          controller: _mobileController,
                          decoration: InputDecoration(
                              label: const Text(AppStrings.mobile),
                              hintText: AppStrings.mobile,
                              errorText: snapshot.data),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: AppSize.s14,
            ),
            Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppPadding.p20,
                ),
                child: Container(
                  width: double.infinity,
                  height: AppSize.s50,
                  decoration: BoxDecoration(
                      border: Border.all(
                          color: ColorManager.grey, width: AppSize.s1_5),
                      borderRadius: BorderRadius.circular(AppSize.s8)),
                  child: GestureDetector(
                    onTap: () {
                      _showImagePicker(context);
                    },
                    child: _getMediaWidget(),
                  ),
                )),
            const SizedBox(
              height: AppSize.s40,
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
                              _viewModel.register();
                            }
                          : null,
                      child: const Text(
                        AppStrings.register,
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
                child: TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, Routes.loginRoute);
                  },
                  child: Text(
                    AppStrings.loginText,
                    style: Theme.of(context).textTheme.labelMedium,
                  ),
                )),
          ],
        ),
      ),
    );
  }

  Widget _getMediaWidget() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppPadding.p8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Flexible(child: Text(AppStrings.profilePic)),
          Flexible(
              child: StreamBuilder<File>(
            stream: _viewModel.outIsProfilePicValid,
            builder: (context, snapshot) {
              return _imagePickedByUser(snapshot.data);
            },
          )),
          const Flexible(child: Icon(Icons.add_a_photo)),
        ],
      ),
    );
  }

  _showImagePicker(BuildContext context) {
    showModalBottomSheet(
        context: context,
        useSafeArea: true,
        enableDrag: true,
        builder: (BuildContext context) {
          return Wrap(
            alignment: WrapAlignment.spaceBetween,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
          ListTile(
            leading: const Icon(Icons.camera_alt),
            title: const Text(AppStrings.photoCamera),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () {
              _imageFromCamera();
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: const Icon(Icons.photo),
            title: const Text(AppStrings.photoGallery),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () {
              _imageFromGallery();
              Navigator.pop(context);
            },
          ),
          ],
          );
        },
        // constraints: BoxConstraints(minHeight: AppSize.s60)
    );
  }

  _imageFromCamera() async {
    var image = await _imagePicker.pickImage(source: ImageSource.camera);
    _viewModel.setProfilePic(File(image?.path ?? ""));
  }

  _imageFromGallery() async {
    var image = await _imagePicker.pickImage(source: ImageSource.gallery);
    _viewModel.setProfilePic(File(image?.path ?? ""));
  }

  _imagePickedByUser(File? image) {
    if (image != null && image.path.isNotEmpty) {
      return Image.file(image);
    } else {
      return Container();
    }
  }

  @override
  void dispose() {
    _viewModel.dispose();
    super.dispose();
  }
}
