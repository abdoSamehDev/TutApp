import 'package:advanced_flutter_arabic/presentation/home/screens/home/view/home_screen.dart';
import 'package:advanced_flutter_arabic/presentation/home/screens/notifications/view/notifications_screen.dart';
import 'package:advanced_flutter_arabic/presentation/home/screens/search/view/search_screen.dart';
import 'package:advanced_flutter_arabic/presentation/home/screens/settings/view/settings_screen.dart';
import 'package:advanced_flutter_arabic/presentation/resources/color_manager.dart';
import 'package:advanced_flutter_arabic/presentation/resources/strings_manager.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  List<Widget> screens = [
    const HomeScreen(),
    const SearchScreen(),
    const NotificationsScreen(),
    const SettingsScreen(),
  ];

  List<String> titles = [
    AppStrings.home.tr(),
    AppStrings.search.tr(),
    AppStrings.notifications.tr(),
    AppStrings.settings.tr(),
  ];

  var _title = AppStrings.home.tr();
  var _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          _title,
          style: Theme.of(context).textTheme.titleMedium,
        ),
      ),
      body: screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: ColorManager.primary,
        unselectedItemColor: ColorManager.grey,
        currentIndex: _currentIndex,
        onTap: onTap,
        items:  [
          BottomNavigationBarItem(
              icon: const Icon(Icons.home_outlined), label: AppStrings.home.tr()),
          BottomNavigationBarItem(
              icon: const Icon(Icons.search), label: AppStrings.search.tr()),
          BottomNavigationBarItem(
              icon: const Icon(Icons.notifications_none_rounded),
              label: AppStrings.notifications.tr()),
          BottomNavigationBarItem(
              icon: const Icon(Icons.settings_outlined), label: AppStrings.settings.tr()),
        ],
      ),
    );
  }

  void onTap(int index) {
    setState(() {
      _currentIndex = index;
      _title = titles[index];
    });
  }
}
