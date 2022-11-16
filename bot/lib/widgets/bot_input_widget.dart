import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/bot_bloc/bot_bloc.dart';
import '../blocs/bot_bloc/bot_event.dart';
import '../models/bot.dart';
import '../models/possible_answer.dart';

class BotInputWidget extends StatelessWidget {
  BotInputWidget(
      {super.key,
      required this.bot,
      required this.scrollController,
      required this.textEditingController});

  final Bot bot;
  final _formKey = GlobalKey<FormState>();
  final ScrollController scrollController;
  final TextEditingController textEditingController;

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.blue,
        padding: EdgeInsets.only(
          top: 10,
          right: 10,
          bottom: MediaQuery.of(context).viewInsets.bottom + 15,
          left: 10,
        ),
        child: Column(
          children: [
            // if (bot.possibleAnswers.isNotEmpty)
            //   _buildPossibleAnswers(context, bot.possibleAnswers),
            _buildTextField(context),
          ],
        ));
  }

  Widget _buildTextField(BuildContext context) {
    return Form(
      key: _formKey,
      child: TextFormField(
        controller: textEditingController,
        autocorrect: false,
        autofocus: true,
        textCapitalization: TextCapitalization.sentences,
        cursorColor: Colors.white,
        keyboardType: TextInputType.multiline,
        maxLines: 2,
        textInputAction: TextInputAction.newline,

        onFieldSubmitted: (value) {
          _sendMessage(context, scrollController, textEditingController.text);
        },
        validator: (value) {
          return _validateMessage(value);
        },
        style: const TextStyle(color: Colors.white),
        decoration: InputDecoration(
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
          ),
          filled: true,
          fillColor: const Color(0xFF1B78C4),
          hintText: 'Type your message...',
          hintStyle: const TextStyle(color: Colors.white54),
          contentPadding: const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
          suffixIcon: IconButton(
            icon: const Icon(Icons.send, color: Colors.white70),
            onPressed: () {
              _sendMessage(context, scrollController, textEditingController.text);
            },
          ),
        ),
      ),
    );
  }

  String? _validateMessage(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please type something';
    } else if (value.length > 100) {
      return 'Please type something shorter';
    }
    return null;
  }

  void _sendMessage(
      BuildContext context, ScrollController scrollController, String message) {
    if (_formKey.currentState!.validate()) {

      message = message.trim();

      BlocProvider.of<BotBloc>(context)
          .add(SentMessageToBotEvent(message, bot, scrollController));
      _formKey.currentState!.reset();
    }
  }
}
