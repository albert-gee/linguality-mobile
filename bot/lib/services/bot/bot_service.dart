import '../../models/bot.dart';
import '../../models/bot_response.dart';
import '../../models/message.dart';
import '../../providers/bot_provider_contract.dart';
import '../../repositories/bot_repository.dart';
import 'bot_service_contract.dart';

class BotService implements BotServiceContract {

  final BotProviderContract provider;
  final BotRepository _botRepository;

  BotService(this.provider) : _botRepository = BotRepository(provider);

  @override
  Future<Bot> init() {
    return _botRepository.init();
  }

  @override
  Future<BotResponse> respond(Message userRequest) {
    return _botRepository.respond(userRequest);
  }
}