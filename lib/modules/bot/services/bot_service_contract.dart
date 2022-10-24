import '../models/bot.dart';
import '../models/message.dart';

abstract class BotServiceContract {

  /// Initiate a conversation with the bot
  Future<Bot> init();

  /// Send a message to the bot
  Future<Message> respond(Message userRequest);
}