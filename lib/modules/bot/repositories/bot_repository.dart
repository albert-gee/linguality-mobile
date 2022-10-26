import 'package:linguality_mobile/modules/bot/models/bot_response.dart';

import '../models/bot.dart';
import '../models/message.dart';
import '../providers/bot_provider.dart';

class BotRepository {
  final _provider = BotProvider();

  Future<Bot> init() => _provider.init();
  Future<BotResponse> respond(Message userRequest) => _provider.respond(userRequest);
}