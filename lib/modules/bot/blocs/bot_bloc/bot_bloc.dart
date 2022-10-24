import 'package:flutter_bloc/flutter_bloc.dart';

import '../../repositories/bot_repository.dart';
import 'bot_event.dart';
import 'bot_state.dart';

class BotBloc extends Bloc<BotEvent, BotState> {

  final BotRepository botRepository = BotRepository();

  BotBloc(): super(BotStateInit()) {

    on<InitBotEvent>((event, emit) async {
      try {
        emit(BotStateInit());

        final bot = await botRepository.init();
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

    on<SendMessageToBotEvent>((event, emit) async {
      try {
        final bot = event.bot;
        bot.messages.add(event.message);
        emit(BotStateMessageSent(bot));

        final botResponse = await botRepository.respond(event.message);
        bot.messages.add(botResponse);
        emit(BotStateMessageResponseReceived(bot));

      } on Error catch (e) {
        print(e);
        emit(const BotStateInitError("Failed to fetch data. is your device online?"));
      }
    });
  }

}



