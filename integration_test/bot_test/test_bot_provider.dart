import 'package:bot/models/bot.dart';
import 'package:bot/models/bot_response.dart';
import 'package:bot/models/message.dart';
import 'package:bot/models/possible_answer.dart';
import 'package:bot/providers/bot_provider_contract.dart';

class TestBotProvider extends BotProviderContract {
  @override
  Future<Bot> init() async {
    return Future(() => Bot(messages: [
          Message(
              id: '1',
              text: 'Hello! How can I help you?',
              userId: 'bot',
              timestamp: DateTime.now())
        ], possibleAnswers: <PossibleAnswer>{
          PossibleAnswer(id: '1', text: 'Hey'),
          PossibleAnswer(id: '2', text: 'Good morning'),
        }));
  }

  @override
  Future<BotResponse> respond(Message userRequest) async {
    return Future(() => BotResponse(
            message: Message(
                id: '1',
                text: 'Hey! How are you?',
                userId: 'bot',
                timestamp: DateTime.now()),
            possibleAnswers: <PossibleAnswer>{
              PossibleAnswer(id: '1', text: 'Hello'),
              PossibleAnswer(id: '2', text: 'Good morning'),
            }));
  }
}
