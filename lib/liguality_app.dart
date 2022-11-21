import 'package:board/providers/article_provider_contract.dart';
import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

import 'package:board/providers/article_paragraph_to_speech_provider_contract.dart';
import 'package:bot/providers/bot_provider_contract.dart';
import 'package:bot/providers/text_to_speech_provider_contract.dart';

import 'package:linguality_mobile/screens/home/home_screen.dart';
import 'package:linguality_mobile/utils/auth/auth_service_contract.dart';

/// The main app widget
class LingualityApp extends StatelessWidget {
  static const String appTitle = 'Linguality';
  final BotProviderContract botProvider;
  final ArticleProviderContract articleProvider;
  final TextToSpeechProviderContract textToSpeechProvider;
  final ArticleParagraphToSpeechProviderContract articleParagraphToSpeechProvider;
  final AuthServiceContract authService;

  const LingualityApp({
    super.key,
    required this.botProvider,
    required this.textToSpeechProvider,
    required this.articleParagraphToSpeechProvider,
    required this.authService,
    required this.articleProvider,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: appTitle,
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
      ),
      home: FutureBuilder<bool>(
        future: authService.authenticate().then((value) async {
          return await Future.delayed(const Duration(seconds: 5), () {return true;});
        }), // for testing purposes
        builder: (
          BuildContext context,
          AsyncSnapshot<bool> snapshot,
        ) {

          Widget returnWidget;

          if (snapshot.connectionState == ConnectionState.waiting) {
            returnWidget = _buildLoadingWidget();
          } else if (snapshot.connectionState == ConnectionState.done) {
            returnWidget = (snapshot.hasData && snapshot.data == false)
                ? _buildErrorWidget('Error')
                : _buildHomeScreen();
          } else {
            returnWidget = _buildLoadingWidget();
          }

          return returnWidget;
        },
      ),
    );
  }

  Widget _buildLoadingWidget() {
    const colorizeTextStyle = TextStyle(
      fontSize: 50.0,
      fontFamily: 'Horizon',
    );
    const colorizeColors = [
      Colors.purple,
      Colors.blue,
      Colors.yellow,
      Colors.red,
    ];

    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxHeight: 300),
          child: Center(
            child: SizedBox(
              width: 250.0,
              child: AnimatedTextKit(
                repeatForever: true,
                pause: const Duration(milliseconds: 250),
                totalRepeatCount: 10,
                animatedTexts: [
                  ColorizeAnimatedText(
                    appTitle,
                    speed: const Duration(milliseconds: 250),
                    textStyle: colorizeTextStyle,
                    colors: colorizeColors,
                    textAlign: TextAlign.center,
                  ),
                ],
                isRepeatingAnimation: true,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildErrorWidget(String error) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Text(
          error,
          style: const TextStyle(
            color: Colors.blue,
            fontSize: 20,
          ),
        ),
      ),
    );
  }

  Widget _buildHomeScreen() {
    return HomeScreen(
      title: appTitle,
      botProvider: botProvider,
      articleProvider: articleProvider,
      textToSpeechProvider: textToSpeechProvider,
      articleParagraphToSpeechProvider: articleParagraphToSpeechProvider,
    );
  }
}
