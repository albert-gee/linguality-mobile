import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:linguality_mobile/modules/bot/models/message.dart';
import 'package:linguality_mobile/modules/bot/widgets/messages_widget.dart';
import 'package:linguality_mobile/modules/bot/widgets/reply_button_widget.dart';

import '../blocs/bot_bloc/bot_bloc.dart';
import '../blocs/bot_bloc/bot_event.dart';
import '../blocs/bot_bloc/bot_state.dart';
import '../models/bot.dart';
import 'bot_slider_widget.dart';
import 'loading_widget.dart';


class BotWidget extends StatelessWidget {

  final BotBloc _botBloc = BotBloc();
  BotWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    // Initialize the bot
    _botBloc.add(InitBotEvent());

    return BlocProvider(
      create: (_) => _botBloc,
      child: BlocListener<BotBloc, BotState>(
        listener: (context, state) {
          // TODO: implement listener
          // Open bot panel when message received

          // Show error message when error received
          if (state is BotStateInitError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.error ?? "Error"),
              ),
            );
          }

          if (state is BotStateInputOpened) {
            // ScaffoldMessenger.of(context).showSnackBar(
            //   const SnackBar(
            //     content: Text("Input opened"),
            //   ),
            // );
          }
        },
        child: BlocBuilder<BotBloc, BotState>(
          builder: (context, state) {

            if (state is BotStateInit) {
              return const LoadingWidget();
            } else if (state is BotStateInitResponseReceived) {
                return _buildConversation(context, state.bot, false);
            } else if (state is BotStateInitError) {
              return Container();
            } else if (state is BotStateInputOpened) {
              return _buildConversation(context, state.bot, true);
              // return Column(
              //   children: [
              //     _buildConversation(context, state.bot),
              //     _buildInputField(context, state.bot),
              //   ],
              // );
            } else if (state is BotStateMessageSent) {
              return _buildConversation(context, state.bot, false);
            } else if (state is BotStateMessageResponseReceived) {
              return _buildConversation(context, state.bot, false);
            } else {
              return Container();
            }

          },
        ),
      ),
    );
  }

  Widget _buildConversation(BuildContext context, Bot bot, bool inputOpened) {

    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(25.0),
        child: BotSliderWidget(),
      ),
      backgroundColor: Colors.white54,
      body: MessagesWidget(bot: bot, inputOpened: inputOpened),
      floatingActionButton: FloatingActionButton.extended(
        key: const Key('homeView_addTodo_floatingActionButton'),
        onPressed: () {
          inputOpened ?
          BlocProvider.of<BotBloc>(context).add(
            SentMessageToBotEvent(
              Message(id: '0', text: bot.messages.last.text, timestamp: DateTime.now(), messageType: MessageType.user), bot)) :
          BlocProvider.of<BotBloc>(context).add(OpenInputForResponseToBotEvent(bot));

          // _botBloc.add(OpenInputForResponseToBotEvent(bot));
        },
        label: Text(inputOpened ? 'Send' : 'Reply'),
        icon: Icon(inputOpened ? Icons.send : Icons.reply),
        backgroundColor: Colors.pink,
      ),
    );

    // return ConstrainedBox(
    //   constraints: BoxConstraints(
    //     maxHeight: MediaQuery.of(context).size.height - 500,
    //     // maxHeight: 150,
    //     minHeight: 15,
    //   ),
    //   child: ListView.builder(
    //     reverse: false,
    //     itemCount: bot.messages.length,
    //     itemBuilder: (context, index) {
    //       final message = bot.messages[index];
    //       return BubbleSpecialThree(
    //         text: message.text,
    //         color: const Color(0xFF1B97F3),
    //         tail: message.messageType == MessageType.user,
    //         isSender: message.messageType == MessageType.user,
    //         textStyle: message.messageType == MessageType.user ?
    //         const TextStyle(color: Colors.black, fontSize: 18) :
    //         const TextStyle(color: Colors.white, fontSize: 18),
    //       );
    //     },
    //   ),
    // );

  }



}