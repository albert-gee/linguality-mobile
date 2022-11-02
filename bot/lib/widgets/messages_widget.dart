import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

import '../models/bot.dart';
import '../models/message.dart';
import 'bot_input_widget.dart';
import 'bot_message_bubble_widget.dart';

class MessagesWidget extends StatelessWidget {
  const MessagesWidget(
      {super.key, required this.bot, this.inputOpened = false, required this.scrollController});

  final Bot bot;
  final bool inputOpened;

  final ScrollController scrollController;



  @override
  Widget build(BuildContext context) {
    List<Message> messages = bot.messages;

    return ListView.builder(
      controller: scrollController,
      reverse: false,
      shrinkWrap: true,
      itemCount: messages.length,
      itemBuilder: (context, index) {

        final Message message = messages[index];
        if (inputOpened && index == messages.length - 1) {
          return ConstrainedBox(
              constraints: BoxConstraints(
                  minHeight: MediaQuery.of(context).size.height - 400),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  BotMessageBubbleWidget(
                    message: message,
                    isSent: true,
                    isDelivered: true,
                    isSeen: true,
                  ),
                  const SizedBox(height: 10),
                  BotInputWidget(bot: bot, scrollController: scrollController,),
                ],
              ));
        } else {
          return AnimationConfiguration.staggeredList(
            position: index,
            duration: const Duration(milliseconds: 500),
            child: SlideAnimation(
              verticalOffset: 10.0,
              child: FadeInAnimation(
                child: BotMessageBubbleWidget(
                  message: message,
                  isSent: true,
                  isDelivered: true,
                  isSeen: true,
                ),
              ),
            ),
          );
        }
      },
    );
  }
}
