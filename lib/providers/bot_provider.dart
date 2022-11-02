import 'package:bot/models/bot.dart';
import 'package:bot/models/bot_response.dart';
import 'package:bot/models/message.dart';
import 'package:bot/models/possible_answer.dart';
import 'package:bot/providers/bot_provider_contract.dart';

import '../configuration/configuration.dart';
import '../utils/key_storage.dart';
import '../utils/api/api.dart';
import '../utils/api/api_response.dart';

class BotProvider extends BotProviderContract {
  final Configuration settings = Configuration();
  final KeyStorage keyStorage = KeyStorage();
  final Api api = Api();

  /// Initiate a conversation with the bot
  @override
  Future<Bot> init() async {
    Bot bot;

    try {
      var token = await keyStorage.read(settings.secureStorageKeyAccessToken);

      if (token != null) {
        ApiResponse apiResponse = await api.post(
            url: '${settings.apiServerUrl}/bot/init', jwt: token);

        if (apiResponse.statusCode == 200 || apiResponse.data != null) {
          bot = Bot.fromJson(apiResponse.data!);
        } else {
          throw Exception('Unsuccessful bot init');
        }
      } else {
        throw Exception("Unauthenticated");
      }
    } catch (error, stacktrace) {
      print("Exception occurred: $error stackTrace: $stacktrace");

      bot = Bot(messages: [
        Message(
            id: '0',
            text: "I couldn't initialize the app. Try again later",
            userId: 'Bot',
            timestamp: DateTime.now())
      ], possibleAnswers: <PossibleAnswer>{});
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
      var token = await keyStorage.read(settings.secureStorageKeyAccessToken);
      if (token != null) {
        ApiResponse apiResponse = await api.post(
            url: '${settings.apiServerUrl}/bot/respond',
            data: {'message': userRequest.text},
            jwt: token);

        if (apiResponse.statusCode == 401) {
          throw Exception("Unauthenticated");
        } else if (apiResponse.statusCode == 200 || apiResponse.data != null) {
          botResponse = BotResponse.fromJson(apiResponse.data!);
        } else {
          throw Exception('Unsuccessful bot response');
        }
      } else {
        throw Exception("Unauthenticated");
      }
    } catch (error, stacktrace) {
      print("Exception occurred: $error stackTrace: $stacktrace");

      if (error.toString() == "Unauthenticated") {
        botResponse = BotResponse(
            message: Message(
                id: '0',
                text: "You are not authenticated. Please login again",
                userId: 'Bot',
                timestamp: DateTime.now()),
            possibleAnswers: <PossibleAnswer>{});
      } else {

        botResponse = BotResponse(
            message: Message(
                id: '0',
                text: "I couldn't respond to your message. Try again later",
                userId: 'Bot',
                timestamp: DateTime.now()),
            possibleAnswers: <PossibleAnswer>{
              PossibleAnswer(
                id: '0',
                text: "Ok, thanks.",
              )
            });
      }
    }

    return botResponse;
  }
}
