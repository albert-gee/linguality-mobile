import '../../models/bot.dart';
import '../../models/bot_response.dart';
import '../../models/message.dart';

abstract class BotServiceContract {

  /// Initiate a conversation with the bot
  Future<Bot> init();

  /// Send a message to the bot
  Future<BotResponse> respond(Message userRequest);
}