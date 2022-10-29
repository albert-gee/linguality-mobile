import 'package:equatable/equatable.dart';

import '../../models/bot.dart';

abstract class BotState extends Equatable {
  const BotState();

  @override
  List<Object?> get props => [];
}

class BotStateInit extends BotState {}

class BotStateInitResponseReceived extends BotState {
  final Bot bot;
  const BotStateInitResponseReceived(this.bot);
}

class BotStateInitError extends BotState {
  final String? error;
  const BotStateInitError(this.error);
}

class BotStateInputOpened extends BotState {
  final Bot bot;
  const BotStateInputOpened(this.bot);
}

class BotStateMessageSent extends BotState {
  final Bot bot;
  const BotStateMessageSent(this.bot);
}

class BotStateMessageResponseReceived extends BotState {
  final Bot bot;
  const BotStateMessageResponseReceived(this.bot);
}