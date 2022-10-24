import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

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
      print(response.data);
      bot = Bot.fromJson(response.data);
    } catch (error, stacktrace) {
      print("Exception occurred: $error stackTrace: $stacktrace");
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

  Future<Message> respond(Message userRequest) async {
    Message message;

    try {
      Response response = await _dio.post("$_baseUrl/bot/respond", data: {
        'message': userRequest.text
      });
      if (response.statusCode != 200) {
        throw Exception('Unsuccessful response');
      }
      message = Message.fromJson(response.data);
    } catch (error, stacktrace) {
      print("Exception occurred: $error stackTrace: $stacktrace");
      message = Message(
          id: '0',
          text: "Something went wrong. I couldn't connect to the server. Try again later",
          messageType: MessageType.bot,
          timestamp: DateTime.now());
    }

    return message;
  }
}
