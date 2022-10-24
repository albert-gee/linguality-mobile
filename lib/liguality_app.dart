import 'package:flutter/material.dart';
import 'package:linguality_mobile/screens/home/home_page.dart';

import 'models/user.dart';

class LingualityApp extends StatelessWidget {

  static const String appTitle = 'Linguality';

  final User user;

  const LingualityApp({required this.user, super.key});

  @override
  Widget build(BuildContext context) {

    // var auth = _authenticate(Uri.parse("http://192.168.50.157:28080/realms/Linguality"), "mobile", []);
    // _authenticate(Uri.parse('https://auth.linguality.com'), 'linguality', ['openid', 'profile', 'email']);

    // auth.then((value) => value.client.httpClient?.post(Uri.parse('http://localhost:18888/assistant/respond'), body: Message(message: 'Hello', messageType: MessageType.sender))
    //     .then((value) => print('dfgdfgh')));


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