import 'package:bot/models/possible_answer.dart';

import 'message.dart';

class Bot {
  final List<Message> messages;
  Set<PossibleAnswer> possibleAnswers;

  Bot({required this.messages, required this.possibleAnswers});

  Map<String, dynamic> toJson() => {
      'messages': messages,
  };

  Bot.fromJson(Map<String, dynamic> json)
      : messages = List<Message>.from(
            json['messages'].map(
                    (x) => Message.fromJson(x)
            )),
        possibleAnswers = Set<PossibleAnswer>.from(
            json['possibleAnswers'].map(
                    (x) => PossibleAnswer.fromJson(x)
            ));
}
