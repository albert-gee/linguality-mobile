import 'package:equatable/equatable.dart';

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

class SentMessageToBotEvent extends BotEvent {
  final Bot bot;
  final String textMessage;

  SentMessageToBotEvent(this.textMessage, this.bot);

  @override
  List<Object> get props => [textMessage, bot];
}
