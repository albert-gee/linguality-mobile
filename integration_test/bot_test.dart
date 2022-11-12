import 'package:bot/widgets/bot_input_widget.dart';
import 'package:bot/widgets/bot_widget.dart';
import 'package:bot/widgets/messages_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:linguality_mobile/liguality_app.dart';

import 'test_bot_provider.dart';
import 'test_text_to_speech_provider.dart';

void main() {

  group('end-to-end test', () {
    testWidgets('initialization', (WidgetTester tester) async {

      final testBotProvider = TestBotProvider();
      final testTextToSpeechProvider = TestTextToSpeechProvider();

      await tester.pumpWidget(LingualityApp(
        isAuthDisabled: true,
        botProvider: testBotProvider,
        textToSpeechProvider: testTextToSpeechProvider,
      ));

      await tester.pumpAndSettle();
      expect(find.byType(BotWidget), findsOneWidget);

      // delay
      await Future.delayed(const Duration(seconds: 1), (){});

      await tester.pumpAndSettle();
      expect(find.byType(MessagesWidget), findsOneWidget);
      expect(find.text('Hello! How can I help you?'), findsOneWidget);
      expect(find.byType(FloatingActionButton), findsOneWidget);

      await tester.pumpAndSettle();
      await tester.tap(find.byType(FloatingActionButton));

      // delay
      await Future.delayed(const Duration(seconds: 1), (){});

      await tester.pumpAndSettle();
      expect(find.byType(BotInputWidget), findsOneWidget);
      expect(find.byType(TextField), findsOneWidget);

      await tester.enterText(find.byType(TextField), 'hi');
      await tester.testTextInput.receiveAction(TextInputAction.done);
      await tester.pumpAndSettle();
      expect(find.text('Hey! How are you?'), findsOneWidget);

      // delay
      await Future.delayed(const Duration(seconds: 1), (){});

      await tester.drag(find.text('Hey! How are you?'), const Offset(500.0, 0.0));
      await tester.pumpAndSettle();
      expect(find.text('Voice'), findsOneWidget);
      expect(find.byIcon(Icons.record_voice_over), findsOneWidget);

      // delay
      await Future.delayed(const Duration(seconds: 1), (){});
    });
  });
}
