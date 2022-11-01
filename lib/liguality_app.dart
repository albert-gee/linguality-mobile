import 'package:flutter/material.dart';
import 'package:linguality_mobile/screens/home/home_page.dart';
import 'package:linguality_mobile/utils/auth/auth_service.dart';

class LingualityApp extends StatelessWidget {

  static const String appTitle = 'Linguality';

  const LingualityApp({super.key});

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      title: appTitle,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: FutureBuilder<bool>(
          future: AuthService().authenticate(),
          builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
            Widget? returnWidget;

            if (snapshot.connectionState == ConnectionState.waiting) {
              returnWidget = const Center(child: CircularProgressIndicator());
            } else if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasData) {
                returnWidget = const HomePage(title: appTitle);
              }
            }

            return returnWidget ?? _buildErrorWidget("Authentication failed");
          }),
    );
  }

  _buildErrorWidget(String error) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            error,
            style: const TextStyle(color: Colors.red),
          ),
        ],
      ),
    );
  }

}
