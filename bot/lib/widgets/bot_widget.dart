import 'package:bot/providers/text_to_speech_provider_contract.dart';
import 'package:bot/services/text_to_speech/text_to_speech_service_contract.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/bot_bloc/bot_bloc.dart';
import '../blocs/bot_bloc/bot_event.dart';
import '../blocs/bot_bloc/bot_state.dart';
import '../models/bot.dart';
import '../providers/bot_provider_contract.dart';
import '../services/bot/bot_service.dart';
import '../services/text_to_speech/text_to_speech_service.dart';
import 'bot_input_widget.dart';
import 'bot_slider_widget.dart';
import 'bot_messages_widget.dart';

class BotWidget extends StatelessWidget {
  final BotBloc botBloc;
  final BotProviderContract botProvider;
  final TextToSpeechProviderContract textToSpeechProvider;
  final TextToSpeechServiceContract textToSpeechService;

  final ScrollController scrollController = ScrollController();
  final TextEditingController textEditingController = TextEditingController();

  BotWidget(
      {Key? key, required this.botProvider, required this.textToSpeechProvider})
      : botBloc = BotBloc(BotService(botProvider)),
        textToSpeechService = TextToSpeechService(textToSpeechProvider),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    // Initialize the bot
    botBloc.add(InitBotEvent());

    return BlocProvider(
      create: (_) => botBloc,
      child: BlocListener<BotBloc, BotState>(
        listener: (context, state) {
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
              _scrollToBottom();
              return _buildConversation(context, state.bot, true);
            } else if (state is BotStateMessageSent) {
              return _buildConversation(context, state.bot, false);
            } else if (state is BotStateMessageResponseReceived) {
              _scrollToBottom();
              return _buildConversation(context, state.bot, false);
            } else {
              return Container();
            }
          },
        ),
      ),
    );
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (scrollController.hasClients) {
        scrollController.animateTo(
          scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  Widget _buildConversation(BuildContext context, Bot bot, bool inputOpened) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Column(
          children: [
            const BotSliderWidget(),
            BotMessagesWidget(
                bot: bot,
                inputOpened: inputOpened,
                scrollController: scrollController,
                textEditingController: textEditingController,
                textToSpeechService: textToSpeechService
            ),
            inputOpened ? BotInputWidget(
              bot: bot,
              scrollController: scrollController,
              textEditingController: textEditingController,
            ) : Container()
          ]
      ),
      floatingActionButton: inputOpened
          ? null
          : _buildFloatingActionButton(context, bot),
    );
  }

  Widget _buildFloatingActionButton(
      BuildContext context, Bot bot) {
    return FloatingActionButton.extended(
      key: const Key('homeView_addTodo_floatingActionButton'),
      onPressed: () {
        BlocProvider.of<BotBloc>(context).add(OpenInputForResponseToBotEvent(bot));
      },

      label: const Text('Reply'),
      icon: const Icon(Icons.reply),
      backgroundColor: Colors.pink,
    );
  }
}
