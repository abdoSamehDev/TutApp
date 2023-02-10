import 'package:advanced_flutter_arabic/presentation/resources/theme_manager.dart';
import 'package:flutter/material.dart';

class MyApp extends StatefulWidget {
  //default constructor
  // const MyApp({Key? key}) : super(key: key);

  //named constructor
  const MyApp._internal();

  //singleton or single instance
  static const MyApp _instance = MyApp._internal();

  //factory
  factory MyApp() => _instance;

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: getApplicationTheme(),
    );
  }
}
