import '../models/bot.dart';
import '../models/bot_response.dart';
import '../models/message.dart';
import '../repositories/bot_repository.dart';
import 'bot_service_contract.dart';

class BotService implements BotServiceContract {

  final BotRepository _botRepository = BotRepository();

  @override
  Future<Bot> init() {
    return _botRepository.init();
  }

  @override
  Future<BotResponse> respond(Message userRequest) {
    return _botRepository.respond(userRequest);

  }
}