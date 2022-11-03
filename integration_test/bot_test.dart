import 'package:bot/widgets/bot_input_widget.dart';
import 'package:bot/widgets/bot_widget.dart';
import 'package:bot/widgets/messages_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:linguality_mobile/liguality_app.dart';

import 'test_bot_provider.dart';

void main() {

  group('end-to-end test', () {
    testWidgets('initialization', (WidgetTester tester) async {

      final repository = TestBotProvider();
      await tester.pumpWidget(LingualityApp(
        isAuthDisabled: true,
        botProvider: repository,
      ));
      // await tester.pumpAndSettle();
      // expect(find.text('Authenticating'), findsOneWidget);

      await tester.pumpAndSettle();
      expect(find.byType(BotWidget), findsOneWidget);

      await tester.pumpAndSettle();
      expect(find.byType(MessagesWidget), findsOneWidget);

      await tester.pumpAndSettle();
      expect(find.byType(MessagesWidget), findsOneWidget);
      expect(find.text('Hello! How can I help you?'), findsOneWidget);
      expect(find.byType(FloatingActionButton), findsOneWidget);

      await tester.pumpAndSettle();

      await tester.tap(find.byType(FloatingActionButton));

      await tester.pumpAndSettle(const Duration(milliseconds: 3000));

      expect(find.byType(BotInputWidget), findsOneWidget);
      expect(find.byType(TextField), findsOneWidget);

      await tester.enterText(find.byType(TextField), 'hi');
      await tester.testTextInput.receiveAction(TextInputAction.done);
      await tester.pumpAndSettle();
      expect(find.text('Hey! How are you?'), findsOneWidget);

    });
  });
}
