import 'package:equatable/equatable.dart';
import 'package:linguality_mobile/modules/bot/models/message.dart';

import '../../models/bot.dart';

abstract class BotEvent extends Equatable {}

class InitBotEvent extends BotEvent {
  InitBotEvent();

  @override
  List<Object> get props => [];
}

class OpenInputForResponseToBotEvent extends BotEvent {
  final Bot bot;

  OpenInputForResponseToBotEvent(this.bot);

  @override
  List<Object> get props => [bot];
}

class SendMessageToBotEvent extends BotEvent {
  final Bot bot;
  final Message message;

  SendMessageToBotEvent(this.message, this.bot);

  @override
  List<Object> get props => [message, bot];
}
