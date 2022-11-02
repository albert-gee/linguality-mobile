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
            Widget returnWidget = _buildLoadingWidget();

            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasData && snapshot.data == false) {
                returnWidget = _buildErrorWidget('Authentication Error');
              } else {
                returnWidget = const HomePage(title: appTitle);
              }
            }

            return returnWidget;
          }),
    );
  }

  _buildLoadingWidget() {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxHeight: 300),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              CircularProgressIndicator(
                color: Colors.blue,
              ),
              SizedBox(height: 20),
              Text(
                'Authenticating...',
                style: TextStyle(
                  color: Colors.blue,
                  fontSize: 20,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _buildErrorWidget(String error) {
    return const Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Text(
          'Authentication Error',
          style: TextStyle(
            color: Colors.blue,
            fontSize: 20,
          ),
        ),
      ),
    );
  }

}
