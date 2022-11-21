import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:linguality_mobile/liguality_app.dart';
import 'auth/test_auth_service.dart';
import 'board_test.dart';
import 'board_test/test_article_paragraph_to_speech_provider.dart';
import 'board_test/test_article_provider.dart';
import 'bot_test.dart';
import 'bot_test/test_bot_provider.dart';
import 'bot_test/test_text_to_speech_provider.dart';

void main() {

  group('end-to-end test', () {
    testWidgets('Testing Linguality', (WidgetTester tester) async {

      final testBotProvider = TestBotProvider();
      final testTextToSpeechProvider = TestTextToSpeechProvider();
      final testArticleParagraphToSpeechProvider = TestArticleParagraphToSpeechProvider();

      await tester.pumpWidget(LingualityApp(
        authService: TestAuthService(),
        botProvider: testBotProvider,
        articleProvider: TestArticleProvider(),
        textToSpeechProvider: testTextToSpeechProvider,
        articleParagraphToSpeechProvider: testArticleParagraphToSpeechProvider,
      ));


      await tester.pumpAndSettle();

      expect(find.byType(FutureBuilder<bool>), findsOneWidget, reason: 'FutureBuilder<bool> not found');
      expect(find.text('Linguality'), findsOneWidget);
      expect(find.byType(AnimatedTextKit), findsOneWidget);

      await tester.pumpAndSettle();
      await Future.delayed(const Duration(seconds: 7), (){});

      /// Test the Board
      await testBoard(tester);

      /// Test the Bot
      await testBot(tester);
    });
  });
}
