import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/bot_bloc/bot_bloc.dart';
import '../blocs/bot_bloc/bot_event.dart';
import '../blocs/bot_bloc/bot_state.dart';
import '../models/bot.dart';
import '../providers/bot_provider_contract.dart';
import 'bot_slider_widget.dart';
import 'messages_widget.dart';


class BotWidget extends StatelessWidget {

  final BotProviderContract botProvider;
  final BotBloc botBloc;

  final ScrollController scrollController = ScrollController();

  BotWidget({Key? key, required this.botProvider}): botBloc = BotBloc(botProvider), super(key: key);

  @override
  Widget build(BuildContext context) {

    // Initialize the bot
    botBloc.add(InitBotEvent());

    return BlocProvider(
      create: (_) => botBloc,
      child: BlocListener<BotBloc, BotState>(
        listener: (context, state) {
          if (state is BotStateMessageResponseReceived) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              scrollController.animateTo(
                scrollController.position.maxScrollExtent,
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeOut,
              );
            });
          }
        },
        child: BlocBuilder<BotBloc, BotState>(
          builder: (context, state) {
            if (state is BotStateInit) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is BotStateInitResponseReceived) {
                return _buildConversation(context, state.bot, false);
            } else if (state is BotStateInitError) {
              return Container();
            } else if (state is BotStateInputOpened) {
              return _buildConversation(context, state.bot, true);
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
      backgroundColor: const Color(0xF1F1F1F1),
      body: MessagesWidget(bot: bot, inputOpened: inputOpened, scrollController: scrollController),
      floatingActionButton: _buildFloatingActionButton(context, inputOpened, bot),
    );
  }

  Widget _buildFloatingActionButton(BuildContext context, bool inputOpened, Bot bot) {
    return inputOpened ? Container() : FloatingActionButton.extended(
      key: const Key('homeView_addTodo_floatingActionButton'),
      onPressed: () {
        BlocProvider.of<BotBloc>(context).add(inputOpened ?
        SentMessageToBotEvent(bot.messages.last.text, bot, scrollController) :
        OpenInputForResponseToBotEvent(bot));
      },
      label: Text(inputOpened ? 'Send' : 'Reply'),
      icon: Icon(inputOpened ? Icons.send : Icons.reply),
      backgroundColor: Colors.pink,
    );
  }

}