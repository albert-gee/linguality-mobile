import 'package:bot/providers/bot_provider_contract.dart';
import 'package:bot/providers/text_to_speech_provider_contract.dart';
import 'package:flutter/material.dart';
import 'package:linguality_mobile/screens/home/home_screen.dart';
import 'package:linguality_mobile/utils/auth/auth_service.dart';

class LingualityApp extends StatelessWidget {
  static const String appTitle = 'Linguality';
  final bool isAuthDisabled;
  final BotProviderContract botProvider;
  final TextToSpeechProviderContract textToSpeechProvider;

  const LingualityApp(
      {super.key, required this.isAuthDisabled, required this.botProvider, required this.textToSpeechProvider});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: appTitle,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: FutureBuilder<bool>(
          future: isAuthDisabled
              ? Future(() => true) // for testing purposes
              : AuthService().authenticate(),
          builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
            Widget returnWidget = _buildLoadingWidget();

            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasData && snapshot.data == false) {
                returnWidget = _buildErrorWidget('Authentication Error');
              } else {
                returnWidget =
                    HomeScreen(title: appTitle, botProvider: botProvider, textToSpeechProvider: textToSpeechProvider,);
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
                'Loading...',
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
