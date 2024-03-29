// import 'dart:async';
//
// import 'package:advanced_flutter_arabic/presentation/resources/assets_manager.dart';
// import 'package:advanced_flutter_arabic/presentation/resources/color_manager.dart';
// import 'package:advanced_flutter_arabic/presentation/resources/constant_manager.dart';
// import 'package:advanced_flutter_arabic/presentation/resources/routes_manager.dart';
// import 'package:flutter/material.dart';
//
// class SplashView extends StatefulWidget {
//   const SplashView({Key? key}) : super(key: key);
//
//   @override
//   State<SplashView> createState() => _SplashViewState();
// }
//
// class _SplashViewState extends State<SplashView> {
//   Timer? _timer;
//
//   _startDelay() {
//     _timer = Timer(const Duration(seconds: AppConstants.splashDelay), () {
//       _goNext();
//     });
//   }
//
//   void _goNext() {
//     Navigator.pushReplacementNamed(context, Routes.onBoardingRoute);
//   }
//
//   @override
//   void initState() {
//     super.initState();
//     _startDelay();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: ColorManager.primary,
//       body: const Center(
//         child: Image(
//           image: AssetImage(
//               ImageAssets.splashLogo
//           ),
//         ),
//       ),
//     );
//   }
//
//   @override
//   void dispose() {
//     _timer?.cancel();
//     super.dispose();
//   }
// }
//
//

import 'package:advanced_flutter_arabic/app/app_prefs.dart';
import 'package:advanced_flutter_arabic/app/di.dart';
import 'package:advanced_flutter_arabic/presentation/onboarding/view/onboarding_view.dart';
import 'package:advanced_flutter_arabic/presentation/resources/color_manager.dart';
import 'package:advanced_flutter_arabic/presentation/resources/constant_manager.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import '../resources/assets_manager.dart';
import '../resources/routes_manager.dart';

class SplashView extends StatefulWidget {

  const SplashView({Key? key}) : super(key: key);

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  final AppPreferences _preferences = instance<AppPreferences>();

  // bool isUserLoggedIn = false;
  String? nextRoute;

  String getNext(){
    _preferences.isUserLoggedIn().then((isUserLoggedIn) =>{
      if(isUserLoggedIn){
        nextRoute = Routes.homeRoute
      } else{
        _preferences.isOnBoardingScreenViewed().then((isOnBoardingScreenViewed) => {
          if(isOnBoardingScreenViewed){
            nextRoute = Routes.loginRoute
          }else{
            nextRoute = Routes.onBoardingRoute
          }
        })
      }
    });
    return nextRoute ?? Routes.onBoardingRoute;
  }

  @override
  void initState() {
    getNext();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // _preferences.isUserLoggedIn().then((value) => isUserLoggedIn = value);
    // _preferences.isOnBoardingScreenViewed().then((value) => isOnBoardingViewed = value);
    return AnimatedSplashScreen(
      splash:  const Image(
        image: AssetImage(ImageAssets.splashLogo),
      ),
      nextScreen: const OnBoardingView(),
      backgroundColor: ColorManager.primary,
      animationDuration: const Duration(seconds: AppConstants.splashAnimationDuration),
      // pageTransitionType: PageTransitionType.fade,
      duration: AppConstants.splashDuration,
      splashIconSize: double.infinity,
      nextRoute: getNext(),
      splashTransition: SplashTransition.scaleTransition,
    );
  }
}
