import 'package:board/widgets/board/board_widget.dart';
import 'package:bot/widgets/bot_header_widget.dart';
import 'package:bot/widgets/bot_widget.dart';
import 'package:flutter/material.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

import '../../liguality_app.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double panelMaxHeight =
        MediaQuery.of(context).size.height - LingualityApp.botPanelMaxHeightGap;

    return Scaffold(
      body: SafeArea(
        child: SlidingUpPanel(
          borderRadius: const BorderRadius.vertical(
            top: Radius.circular(LingualityApp.botPanelBorderRadius),
          ),
          controller: LingualityApp.botPanelController,
          color: Theme.of(context).dialogBackgroundColor,
          defaultPanelState: PanelState.CLOSED,
          minHeight: LingualityApp.botPanelMinHeight,
          maxHeight: panelMaxHeight,
          snapPoint: LingualityApp.botPanelSnapPoint,
          header: const BotHeaderWidget(),
          body: BoardWidget(
            appTitle: LingualityApp.appTitle,
            appTitleIcon: LingualityApp.appTitleIcon,
            storyProvider: LingualityApp.storyProvider,
            articleParagraphToSpeechProvider:
                LingualityApp.articleParagraphToSpeechProvider,
          ),
          panel: BotWidget(
            botProvider: LingualityApp.botProvider,
            textToSpeechProvider: LingualityApp.textToSpeechProvider,
          ),
        )
      ),
      // floatingActionButton: const ReplyButtonWidget()
    );
  }
}
