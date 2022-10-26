import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:linguality_mobile/modules/bot/models/bot_response.dart';
import 'package:linguality_mobile/modules/bot/models/possible_answer.dart';

import '../models/bot.dart';
import '../models/message.dart';

class BotProvider {
  final Dio _dio = Dio();
  final String _baseUrl = "http://192.168.50.30:18888";

  /// Initiate a conversation with the bot
  Future<Bot> init() async {
    Bot bot;
    try {
      var storage = const FlutterSecureStorage();
      var token = await storage.read(key: 'jwt',
        iOptions: const IOSOptions(),
        aOptions: const AndroidOptions(
          encryptedSharedPreferences: true,
        ),);
      Response response = await _dio.post("$_baseUrl/bot/init",
        data: {},
        options: Options(headers: {
          "Content-Type": "application/json",
          "Authorization":
          "Bearer $token",
        })
      );
      if (response.statusCode != 200) {
        throw Exception('Unsuccessful bot init');
      }
      bot = Bot.fromJson(response.data);
    } catch (error, stacktrace) {
      bot = Bot(messages: [
        Message(
          id: '0',
          text: "Something went wrong. I couldn't initialize. Try again later",
          messageType: MessageType.bot,
          timestamp: DateTime.now())
      ]);
    }

    return bot;
  }

  Future<BotResponse> respond(Message userRequest) async {
    BotResponse botResponse;

    try {
      var storage = const FlutterSecureStorage();
      var token = await storage.read(key: 'jwt',
        iOptions: const IOSOptions(),
        aOptions: const AndroidOptions(
          encryptedSharedPreferences: true,
        ),);

      print("USER REQUEST: ${userRequest.text}");
      print("TOKEN: $token");

      Response response = await _dio.post(
        "$_baseUrl/bot/respond",
        data: {
          'message': userRequest.text
        },
        options: Options(headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token",
        })
      );

      print("response: ${response.data}");


      if (response.statusCode != 200) {
        throw Exception('Unsuccessful response');
      }
      botResponse = BotResponse.fromJson(response.data);
    } catch (error, stacktrace) {

      print(error);
      print(stacktrace);

      Set<PossibleAnswer> possibleAnswers = <PossibleAnswer>{
        PossibleAnswer(
          id: '0',
          text: "Ok, thanks.",
        )
      };
      botResponse = BotResponse(
        message: Message(
          id: '0',
          text: "Something went wrong. I couldn't respond. Try again later",
          messageType: MessageType.bot,
          timestamp: DateTime.now()),
        possibleAnswers: possibleAnswers
      );
    }

    return botResponse;
  }
}
