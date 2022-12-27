import 'package:board/providers/article_provider_contract.dart';
import 'package:board/providers/story_provider_contract.dart';
import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

import 'package:board/providers/article_paragraph_to_speech_provider_contract.dart';
import 'package:bot/providers/bot_provider_contract.dart';
import 'package:bot/providers/text_to_speech_provider_contract.dart';
import 'package:linguality_mobile/providers/article_paragraph_to_speech_provider.dart';
import 'package:linguality_mobile/providers/story_provider.dart';
import 'package:linguality_mobile/providers/bot_provider.dart';
import 'package:linguality_mobile/providers/text_to_speech_provider.dart';

import 'package:linguality_mobile/screens/home/home_screen.dart';
import 'package:linguality_mobile/utils/api/api.dart';
import 'package:linguality_mobile/utils/auth/auth_service.dart';
import 'package:linguality_mobile/utils/auth/auth_service_contract.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

/// The main app widget
class LingualityApp extends StatelessWidget {
  static const String appTitle = 'Linguality';
  static const IconData appTitleIcon = Icons.psychology;

  /// Bot Panel Settings
  static const double botPanelBorderRadius = 10.0;
  static const double botPanelMinHeight = 150;
  static const double botPanelMaxHeightGap = 50;
  static const double botPanelSnapPoint = 0.5;

  /// Controllers
  static final PanelController botPanelController = PanelController();

  /// Services
  static final AuthServiceContract auth = AuthService();
  static final Api api = Api(auth: auth);

  /// Providers
  static final ArticleParagraphToSpeechProviderContract articleParagraphToSpeechProvider = ArticleParagraphToSpeechProvider(api: api);
  static final StoryProviderContract storyProvider = StoryProvider(api: api);
  static final BotProviderContract botProvider = BotProvider(api: api);
  static final TextToSpeechProviderContract textToSpeechProvider = TextToSpeechProvider(api: api);

  /// Theme Data
  static final ThemeData themeData = ThemeData(
      dialogBackgroundColor: Colors.blueGrey.shade50,
      primarySwatch: Colors.blueGrey,
      primaryColor: Colors.grey[300]);

  const LingualityApp({
    super.key,
  });

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      home: const HomeScreen(),
      theme: themeData,
    );
  }

  // @override
  // Widget build(BuildContext context) {
  //   double panelMaxHeight = MediaQuery.of(context).size.height - _panelMaxHeightGap;
  //
  //   return MaterialApp(
  //     title: appTitle,
  //     theme: themeData,
  //     home: FutureBuilder<bool>(
  //       future: authService.authenticate().then((value) async {
  //         return await Future.delayed(const Duration(seconds: 5), () {
  //           return true;
  //         });
  //       }), // for testing purposes
  //       builder: (
  //         BuildContext context,
  //         AsyncSnapshot<bool> snapshot,
  //       ) {
  //         Widget returnWidget;
  //
  //         if (snapshot.connectionState == ConnectionState.waiting) {
  //           returnWidget = _buildLoadingWidget();
  //         } else if (snapshot.connectionState == ConnectionState.done) {
  //           returnWidget = (snapshot.hasData && snapshot.data == false)
  //               ? _buildErrorWidget('Error')
  //               : _buildHomeScreen();
  //         } else {
  //           returnWidget = _buildLoadingWidget();
  //         }
  //
  //         return returnWidget;
  //       },
  //     ),
  //   );
  // }

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

// Widget _buildHomeScreen() {
//   return HomeScreen(
//     appTitle: appTitle,
//     appTitleIcon: appTitleIcon,
//     botProvider: botProvider,
//     articleProvider: articleProvider,
//     textToSpeechProvider: textToSpeechProvider,
//     articleParagraphToSpeechProvider: articleParagraphToSpeechProvider,
//   );
// }
}
