import 'package:advanced_flutter_arabic/presentation/home/screens/home_screen.dart';
import 'package:advanced_flutter_arabic/presentation/home/screens/notifications_screen.dart';
import 'package:advanced_flutter_arabic/presentation/home/screens/search_screen.dart';
import 'package:advanced_flutter_arabic/presentation/home/screens/settings_screen.dart';
import 'package:advanced_flutter_arabic/presentation/resources/color_manager.dart';
import 'package:advanced_flutter_arabic/presentation/resources/strings_manager.dart';
import 'package:flutter/material.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  List<Widget> screens = [
    HomeScreen(),
    SearchScreen(),
    NotificationsScreen(),
    SettingsScreen(),
  ];

  List<String> titles = [
    AppStrings.home,
    AppStrings.search,
    AppStrings.notifications,
    AppStrings.settings,
  ];

  var _title = AppStrings.home;
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
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined), label: AppStrings.home),
          BottomNavigationBarItem(
              icon: Icon(Icons.search), label: AppStrings.search),
          BottomNavigationBarItem(
              icon: Icon(Icons.notifications_none_rounded),
              label: AppStrings.notifications),
          BottomNavigationBarItem(
              icon: Icon(Icons.settings_outlined), label: AppStrings.settings),
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
