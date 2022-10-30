import 'package:bot/widgets/bot_widget.dart';
import 'package:flutter/material.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

import 'board.dart';
import '../../providers/bot_provider.dart';

class HomePage extends StatelessWidget {
    const HomePage({super.key, required this.title});

  final String title;

  final double _panelHeightOpen = 50;

  @override
  Widget build(BuildContext context) {
    double panelHeightClosed = MediaQuery.of(context).size.height - 500;

    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: SlidingUpPanel(
        minHeight: _panelHeightOpen,
        maxHeight: panelHeightClosed,
        defaultPanelState: PanelState.OPEN,
        controller: PanelController(),

        body: const Board(),
        panel: BotWidget(botProvider: BotProvider()),

      ),
      // floatingActionButton: const ReplyButtonWidget()
    );
  }
}
