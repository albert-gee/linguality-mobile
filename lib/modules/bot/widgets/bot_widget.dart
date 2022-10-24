import 'package:flutter/material.dart';
import 'package:linguality_mobile/modules/bot/widgets/bot_conversation_widget.dart';

import 'bot_slider_widget.dart';

class BotWidget extends StatelessWidget {

  BotWidget({super.key});

  @override
  Widget build(BuildContext context) {

    return Column(
      children: [

        const BotSliderWidget(),

        BotConversationWidget(),

      ],
    );
  }

}