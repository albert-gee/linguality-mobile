import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/bot_bloc/bot_bloc.dart';
import '../blocs/bot_bloc/bot_event.dart';
import '../models/bot.dart';
import '../models/possible_answer.dart';

class BotInputWidget extends StatelessWidget {
  const BotInputWidget({super.key, required this.bot, required this.scrollController});

  final Bot bot;
  final ScrollController scrollController;

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.blue,
        child: Column(
          children: [
            if (bot.possibleAnswers.isNotEmpty)
              _buildPossibleAnswers(context, bot.possibleAnswers),

            _buildTextField(context),
          ],
        ));
  }

  Widget _buildTextField(BuildContext context) {
    return TextField(
      style: const TextStyle(color: Colors.white),
      textCapitalization: TextCapitalization.sentences,
      cursorColor: Colors.white,
      decoration: const InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
        ),
        filled: true,
        fillColor: Color(0xFF1B78C4),
        hintText: 'Type your message...',
        hintStyle: TextStyle(color: Colors.white54),
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),

      ),
      autocorrect: false,
      autofocus: true,
      onSubmitted: (String textMessage) async {
        BlocProvider.of<BotBloc>(context)
            .add(SentMessageToBotEvent(textMessage, bot, scrollController));
      },
    );
  }

  Widget _buildPossibleAnswers(
      BuildContext context, Set<PossibleAnswer> possibleAnswers) {
    return Column(
      children: [
        ListView.builder(
          reverse: true,
          shrinkWrap: true,
          itemCount: possibleAnswers.length,
          scrollDirection: Axis.vertical,
          itemBuilder: (context, index) {
            final possibleAnswer = possibleAnswers.elementAt(index);
            return ElevatedButton(
              onPressed: () {
                BlocProvider.of<BotBloc>(context)
                    .add(SentMessageToBotEvent(possibleAnswer.text, bot, scrollController));
              },
              child: Text(possibleAnswer.text),
            );
          },
        ),
        const SizedBox(height: 10),
      ]
    );

  }
}
