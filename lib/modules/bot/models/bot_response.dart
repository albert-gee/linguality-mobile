import 'package:linguality_mobile/modules/bot/models/possible_answer.dart';

import 'message.dart';

class BotResponse {
  final Message message;
  final Set<PossibleAnswer> possibleAnswers;

  BotResponse({required this.message, required this.possibleAnswers});

  Map<String, dynamic> toJson() => {
        'messages': message,
        'possibleAnswers': possibleAnswers,
      };

  BotResponse.fromJson(Map<String, dynamic> json)
      : message = Message.fromJson(json['message']),
        possibleAnswers = Set<PossibleAnswer>.from(
            json['possibleAnswers'].map((x) => PossibleAnswer.fromJson(x)));
}
