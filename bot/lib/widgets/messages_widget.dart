import 'package:chat_bubbles/bubbles/bubble_special_three.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/bot_bloc/bot_bloc.dart';
import '../blocs/bot_bloc/bot_event.dart';
import '../models/bot.dart';
import '../models/message.dart';
import '../models/possible_answer.dart';

class MessagesWidget extends StatelessWidget {
  const MessagesWidget(
      {super.key, required this.bot, this.inputOpened = false});

  final Bot bot;
  final bool inputOpened;

  Widget _buildMessageBubble(BuildContext context, Message message, {isSent = true, bool isDelivered = true, bool isSeen = true}) {
    return BubbleSpecialThree(
      isSender: message.userId == 'Bot',
      text: message.text,
      color: message.userId == 'Bot'
          ? const Color(0xFF1B97F3)
          : const Color(0xFF005073),
      tail: true,
      sent: isSent,
      delivered: isDelivered,
      seen: isSeen,
      textStyle: const TextStyle(color: Colors.white, fontSize: 18),
    );
  }

  Widget _buildTextField(BuildContext context) {
    return TextField(
      decoration: const InputDecoration(
        border: OutlineInputBorder(),
        labelText: 'Message',
      ),
      autocorrect: false,
      autofocus: true,
      onSubmitted: (String textMessage) async {
        // var message = Message(id: '0',
        //     text: text,
        //     timestamp: DateTime.now(),
        //     userId: '0');
        BlocProvider.of<BotBloc>(context).add(
            SentMessageToBotEvent(textMessage, bot));
      },
    );
  }

  Widget _buildPossibleAnswers(BuildContext context, Set<PossibleAnswer> possibleAnswers) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 20.0),
      height: 100.0,
      child: ListView.builder(
        reverse: true,
        shrinkWrap: true,
        itemCount: possibleAnswers.length,
        scrollDirection: Axis.vertical,
        itemBuilder: (context, index) {
          final possibleAnswer = possibleAnswers.elementAt(index);
          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
            width: 160.0,
            color: [Colors.red, Colors.blue, Colors.green, Colors.yellow, Colors.orange].elementAt(index),
            child: Text(
              possibleAnswer.text,
              style: const TextStyle(color: Colors.white, fontSize: 18),
            ),
          );
        },
      ),
    );

  }

  @override
  Widget build(BuildContext context) {
    List<Message> messages = bot.messages;
    Set<PossibleAnswer> possibleAnswers = bot.possibleAnswers;

    return ListView.builder(
      reverse: true,
      shrinkWrap: true,
      itemCount: messages.length,
      itemBuilder: (context, index) {
        if (inputOpened && index == 0) {
          final Message message = messages[messages.length - index - 1];

          return Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                _buildMessageBubble(context, message),
                _buildPossibleAnswers(context, possibleAnswers),
                _buildTextField(context)
              ]
          );

          // return Container(
          //   constraints: BoxConstraints(
          //     minHeight: MediaQuery.of(context).size.height - 525,
          //   ),
          //   child: Column(
          //       children: [
          //         _buildMessageBubble(context, message),
          //         _buildTextField(context)
          //       ]
          //   )
          //
          // );
        } else {
          final Message message = messages[messages.length - index - 1];
          return _buildMessageBubble(context, message);
        }
      },
    );
  }


// Widget createMessageWidget(BuildContext context, Message message) {
//   return AnimationConfiguration.staggeredList(
//     position: 1,
//     duration: const Duration(milliseconds: 375),
//     child: SlideAnimation(
//       verticalOffset: 50.0,
//       child: FadeInAnimation(
//         child: BubbleSpecialThree(
//           text: message.text,
//           isSender: message.isFromBot,
//           color: message.isFromBot ? Colors.blue : Colors.green,
//           nip: message.isFromBot ? BubbleNip.leftTop : BubbleNip.rightTop,
//         ),
//       ),
//     ),
//   );
// }
}
