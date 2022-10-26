import 'message.dart';

class Bot {
  final List<Message> messages;

  Bot({required this.messages});

  Map<String, dynamic> toJson() => {
      'messages': messages,
  };

  Bot.fromJson(Map<String, dynamic> json)
      : messages = List<Message>.from(
            json['messages'].map(
                    (x) => Message.fromJson(x)
            ));
}
