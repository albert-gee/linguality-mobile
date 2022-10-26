import 'package:chat_bubbles/bubbles/bubble_special_three.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/bot_bloc/bot_bloc.dart';
import '../blocs/bot_bloc/bot_event.dart';
import '../models/bot.dart';
import '../models/message.dart';

class MessagesWidget extends StatelessWidget {
  const MessagesWidget({super.key, required this.bot, this.inputOpened = false});

  final Bot bot;
  final bool inputOpened;

  Widget _buildMessageBubble(BuildContext context, Message message) {
    return BubbleSpecialThree(
      isSender: message.messageType == MessageType.user,
      text: message.text,
      color: message.messageType == MessageType.user
          ? const Color(0xFF1B97F3)
          : const Color(0xFF005073),
      tail: true,
      sent: true,
      delivered: true,
      seen: true,
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
      onSubmitted: (String text) async {
        var message = Message(id: '0', text: text, timestamp: DateTime.now(), messageType: MessageType.user);
        BlocProvider.of<BotBloc>(context).add(SentMessageToBotEvent(message, bot));
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    List<Message> messages = bot.messages;

    return ListView.builder(
      reverse: true,
      shrinkWrap: true,
      itemCount: messages.length,
      itemBuilder: (context, index) {

        print('MESSAGES: $messages - ${messages[0].text}');
        print('LENGTH: ${messages.length}');
        print('INDEX: $index');

        if (inputOpened && index == 0) {
          final Message message = messages[messages.length - index - 1];

          return Column(
              children: [
                _buildMessageBubble(context, message),
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
