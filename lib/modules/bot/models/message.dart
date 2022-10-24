class Message {
  final String id;
  final String text;
  final MessageType messageType;
  final DateTime timestamp;

  Message({required this.id, required this.text, required this.messageType, required this.timestamp});

  Message.fromJson(Map<String, dynamic> json):
    id = json['id'],
    text = json['text'],
    messageType = MessageType.bot.key == json['messageType'] ? MessageType.bot : MessageType.user,
    timestamp = DateTime.parse(json['timestamp']);

  Map<String, dynamic> toJson() => {
    'id': id,
    'text': text,
    'messageType': messageType,
    'timestamp': timestamp.toIso8601String(),
  };

}

enum MessageType {
  bot('BOT'),
  user('USER');

  final String key;

  const MessageType(this.key);
}