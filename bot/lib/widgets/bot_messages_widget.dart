import 'package:bot/services/text_to_speech/text_to_speech_service_contract.dart';
import 'package:bot/widgets/bot_possible_answers_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

import '../models/bot.dart';
import '../models/message.dart';
import 'bot_message_bubble_widget.dart';

class BotMessagesWidget extends StatelessWidget {
  const BotMessagesWidget(
      {super.key,
      required this.bot,
      this.inputOpened = false,
      required this.scrollController,
      required this.textEditingController,
      required this.textToSpeechService});

  final Bot bot;
  final bool inputOpened;

  final TextToSpeechServiceContract textToSpeechService;

  final ScrollController scrollController;
  final TextEditingController textEditingController;

  @override
  Widget build(BuildContext context) {
    List<Message> messages = bot.messages;

    return Expanded(
        child: ListView.builder(
          controller: scrollController,
          reverse: false,
          shrinkWrap: true,
          itemCount: inputOpened ? messages.length + 1 : messages.length, // +1 for input
          itemBuilder: (context, index) {
            return _buildListItem(context, index);
          },
        ));
  }

  Widget _buildListItem(BuildContext context, int index) {
    if (inputOpened && index == bot.messages.length) {
      return BotPossibleAnswersWidget(
        textEditingController: textEditingController,
        possibleAnswers: bot.possibleAnswers,
        textToSpeechService: textToSpeechService,
      );
    } else {
      final Message message = bot.messages[index];
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
                textToSpeechService: textToSpeechService,
              )
          ),
        ),
      );
    }
  }
}
