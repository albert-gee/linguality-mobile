import 'package:bot/services/bot/bot_service_contract.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../models/bot_response.dart';
import '../../models/message.dart';
import 'bot_event.dart';
import 'bot_state.dart';

class BotBloc extends Bloc<BotEvent, BotState> {

  final BotServiceContract _botService;

  BotBloc(this._botService): super(BotStateInit()) {

    on<InitBotEvent>((event, emit) async {
      try {
        emit(BotStateInit());

        final bot = await _botService.init();
        emit(BotStateInitResponseReceived(bot));

      } on Error catch (e) {
        emit(const BotStateInitError("Failed to fetch data. is your device online?"));
      }
    });

    on<OpenInputForResponseToBotEvent>((event, emit) async {
      try {
        emit(BotStateInputOpened(event.bot));
      } on Error catch (e) {
        emit(const BotStateInitError("Failed to fetch data. is your device online?"));
      }
    });

    on<SentMessageToBotEvent>((event, emit) async {
      try {
        final bot = event.bot;
        var message = Message(id: '0',
            text: event.textMessage,
            timestamp: DateTime.now(),
            userId: '0');
        bot.messages.add(message);
        emit(BotStateMessageSent(bot));

        final BotResponse botResponse = await _botService.respond(message);
        bot.messages.add(botResponse.message);
        bot.possibleAnswers = botResponse.possibleAnswers;

        emit(BotStateMessageResponseReceived(bot));

      } on Error catch (e) {
        print(e);
        emit(const BotStateInitError("Failed to fetch data. is your device online?"));
      }
    });
  }

}



