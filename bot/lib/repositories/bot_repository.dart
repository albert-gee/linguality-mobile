import 'package:bot/providers/bot_provider_contract.dart';

import '../models/bot.dart';
import '../models/bot_response.dart';
import '../models/message.dart';

class BotRepository {
  final BotProviderContract _provider;

  BotRepository(BotProviderContract provider) : _provider = provider;

  Future<Bot> init() => _provider.init();
  Future<BotResponse> respond(Message userRequest) => _provider.respond(userRequest);
}