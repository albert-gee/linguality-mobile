import 'package:bot/providers/bot_provider_contract.dart';
import 'package:bot/widgets/bot_widget.dart';
import 'package:flutter/material.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

import 'board.dart';

class HomeScreen extends StatelessWidget {
    const HomeScreen({super.key, required this.title, required this.botProvider});

  final String title;
  final BotProviderContract botProvider;

  final double _panelHeightOpen = 50;

  @override
  Widget build(BuildContext context) {
    double panelHeightClosed = MediaQuery.of(context).size.height - 400;

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
        panel: BotWidget(botProvider: botProvider),

      ),
      // floatingActionButton: const ReplyButtonWidget()
    );
  }
}
