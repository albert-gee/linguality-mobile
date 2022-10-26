import 'package:flutter/material.dart';
import 'package:linguality_mobile/screens/home/home_page.dart';

import 'models/user.dart';

class LingualityApp extends StatelessWidget {

  static const String appTitle = 'Linguality';

  final User user;

  const LingualityApp({required this.user, super.key});

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      title: appTitle,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(
          title: appTitle,
          user: user
      ),
    );
  }
}