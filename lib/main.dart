import 'package:flutter/material.dart';
import 'package:linguality_mobile/pages/home/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  static const String appTitle = 'Linguality';

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      title: appTitle,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomePage(title: appTitle),
    );
  }
}

