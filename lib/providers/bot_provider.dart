import 'package:bot/models/bot.dart';
import 'package:bot/models/bot_response.dart';
import 'package:bot/models/message.dart';
import 'package:bot/models/possible_answer.dart';
import 'package:bot/providers/bot_provider_contract.dart';

import '../configuration/configuration.dart';
import '../utils/api/api.dart';
import '../utils/api/api_response.dart';

class BotProvider extends BotProviderContract {
  final Configuration settings = Configuration();
  final Api api = Api();

  /// Initiate a conversation with the bot
  @override
  Future<Bot> init() async {
    Bot bot;

    try {
      ApiResponse apiResponse = await api.post(url: '${settings.apiServerUrl}/bot/init');

      if (apiResponse.statusCode == 200 && apiResponse.data != null) {
        bot = Bot.fromJson(apiResponse.data!);
      } else {
        throw Exception('Unsuccessful bot init');
      }
    } catch (error, stacktrace) {
      print("Exception occurred: $error stackTrace: $stacktrace");

      bot = Bot(
        messages: [
          Message(
            id: '0',
            text: "I couldn't initialize the app. Try again later",
            userId: 'bot',
            timestamp: DateTime.now(),
          ),
        ],
        possibleAnswers: <PossibleAnswer>{},
      );
    }

    return bot;
  }

  @override
  Future<BotResponse> respond(Message userRequest) async {
    BotResponse botResponse;

    try {
      await Future.delayed(const Duration(seconds: 3), () {
        print("Delayed");
      });
      ApiResponse apiResponse =
          await api.post(url: '${settings.apiServerUrl}/bot/respond', data: {'message': userRequest.text});

      if (apiResponse.statusCode == 401) {
        throw Exception("Unauthenticated");
      } else if (apiResponse.statusCode == 200 || apiResponse.data != null) {
        botResponse = BotResponse.fromJson(apiResponse.data!);
      } else {
        throw Exception('Unsuccessful bot response');
      }
    } catch (error, stacktrace) {
      print("Exception occurred: $error stackTrace: $stacktrace");

      botResponse = BotResponse(
        message: Message(
          id: '0',
          text: (error.toString() == "Unauthenticated")
              ? "You are not authenticated. Please login again"
              : "I couldn't respond to your message. Try again later",
          userId: 'bot',
          timestamp: DateTime.now(),
        ),
        possibleAnswers: (error.toString() == "Unauthenticated")
            ? <PossibleAnswer>{}
            : <PossibleAnswer>{
                PossibleAnswer(
                  id: '0',
                  text: "Ok, thanks.",
                ),
              },
      );
    }

    return botResponse;
  }
}
