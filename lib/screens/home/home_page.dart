import 'package:flutter/material.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

import '../../models/user.dart';
import '../../modules/bot/widgets/bot_widget.dart';
import '../../modules/board/widgets/board.dart';

class HomePage extends StatelessWidget {
    const HomePage({super.key, required this.title, required this.user});

  final String title;
  final User user;

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

        body: Board(user: user),
        panel: BotWidget(),

      ),
      // floatingActionButton: const ReplyButtonWidget()
    );
  }
}
