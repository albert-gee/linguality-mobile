import 'package:board/widgets/articles/article_widget.dart';
import 'package:board/widgets/articles/latest_articles_card_widget.dart';
import 'package:board/widgets/articles/latest_articles_widget.dart';
import 'package:board/widgets/board_widget.dart';
import 'package:flutter_test/flutter_test.dart';

Future<void> testBoard(WidgetTester tester) async {
  await tester.pumpAndSettle();

  /// Expect the BoardWidget to be present
  expect(find.byType(BoardWidget), findsOneWidget);

  /// Delay 1s
  await Future.delayed(const Duration(seconds: 1), (){});

  await tester.pumpAndSettle();

  /// Expect the LatestArticlesWidget to be present
  expect(find.byType(LatestArticlesWidget), findsOneWidget);
  await tester.pumpAndSettle();

  /// Expect 3 LatestArticlesCardWidget widgets to be present
  expect(find.byType(LatestArticlesCardWidget), findsNWidgets(3));

  /// Tap the first LatestArticlesCardWidget
  await tester.tap(find.byType(LatestArticlesCardWidget).at(1));
  await tester.pumpAndSettle();

  await Future.delayed(const Duration(seconds: 3), (){});

  /// Expect the Article widget to be present
  expect(find.byType(ArticleWidget), findsNWidgets(1));
  expect(find.text('Test Article'), findsOneWidget);
}
