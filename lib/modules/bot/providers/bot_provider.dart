import 'package:linguality_mobile/modules/bot/models/bot_response.dart';
import 'package:linguality_mobile/modules/bot/models/possible_answer.dart';
import 'package:linguality_mobile/utils/api/api.dart';
import 'package:linguality_mobile/utils/api/api_response.dart';

import '../../../utils/key_storage.dart';
import '../../../configuration/configuration.dart';
import '../models/bot.dart';
import '../models/message.dart';

class BotProvider {

  final Configuration settings = Configuration();
  final KeyStorage keyStorage = KeyStorage();
  final Api api = Api();

  /// Initiate a conversation with the bot
  Future<Bot> init() async {
    Bot bot;

    try {
      var token = await keyStorage.read(settings.secureStorageKeyJwt);

      if(token != null) {
        ApiResponse apiResponse = await api.post(
            url: '${settings.apiServerUrl}/bot/init',
            jwt: token);

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

      bot = Bot(
          messages: [
            Message(
              id: '0',
              text: "Something went wrong. I couldn't initialize. Try again later",
              messageType: MessageType.bot,
              timestamp: DateTime.now())],
          possibleAnswers: <PossibleAnswer>{});
    }

    return bot;
  }

  Future<BotResponse> respond(Message userRequest) async {
    BotResponse botResponse;

    try {
      var token = await keyStorage.read(settings.secureStorageKeyJwt);

      if(token != null) {
        ApiResponse apiResponse = await api.post(
          url: '${settings.apiServerUrl}/bot/respond',
          data: {'message': userRequest.text},
          jwt: token);

        if (apiResponse.statusCode == 200 || apiResponse.data != null) {
          botResponse = BotResponse.fromJson(apiResponse.data!);

        } else {
          throw Exception('Unsuccessful response');
        }
      } else {
        throw Exception("Unauthenticated");
      }
    } catch (error, stacktrace) {

      botResponse = BotResponse(
        message: Message(
          id: '0',
          text: "Something went wrong. I couldn't respond. Try again later",
          messageType: MessageType.bot,
          timestamp: DateTime.now()),
        possibleAnswers: <PossibleAnswer>{
          PossibleAnswer(
            id: '0',
            text: "Ok, thanks.",
          )
        }
      );
    }

    return botResponse;
  }
}
