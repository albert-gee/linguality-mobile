import 'package:board/providers/article_paragraph_to_speech_provider_contract.dart';
import 'package:board/providers/article_provider_contract.dart';
import 'package:board/widgets/board_widget.dart';
import 'package:bot/providers/bot_provider_contract.dart';
import 'package:bot/providers/text_to_speech_provider_contract.dart';
import 'package:bot/widgets/bot_widget.dart';
import 'package:flutter/material.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({
    super.key,
    required this.title,
    required this.botProvider,
    required this.articleProvider,
    required this.textToSpeechProvider,
    required this.articleParagraphToSpeechProvider,
  });

  final String title;
  final BotProviderContract botProvider;
  final ArticleProviderContract articleProvider;
  final TextToSpeechProviderContract textToSpeechProvider;
  final ArticleParagraphToSpeechProviderContract articleParagraphToSpeechProvider;

  final double _panelHeightOpen = 50;

  @override
  Widget build(BuildContext context) {
    double panelHeightClosed = MediaQuery.of(context).size.height - 400;

    return Scaffold(
      body: SlidingUpPanel(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20.0),
          topRight: Radius.circular(20.0),
        ),
        minHeight: _panelHeightOpen,
        maxHeight: panelHeightClosed,
        defaultPanelState: PanelState.OPEN,
        controller: PanelController(),
        body: BoardWidget(
          articleProvider: articleProvider,
          articleParagraphToSpeechProvider: articleParagraphToSpeechProvider,
        ),
        panel: BotWidget(
          botProvider: botProvider,
          textToSpeechProvider: textToSpeechProvider,
        ),
      ),
      // floatingActionButton: const ReplyButtonWidget()
    );
  }
}
