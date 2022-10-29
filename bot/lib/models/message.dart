class Message {
  final String id;
  final String text;
  final String userId;
  final DateTime timestamp;

  Message({required this.id, required this.text, required this.userId, required this.timestamp});

  Message.fromJson(Map<String, dynamic> json):
    id = json['id'],
    text = json['text'],
    userId = json['fromUser']['externalId'],
    timestamp = DateTime.parse(json['createdAt']);

  Map<String, dynamic> toJson() => {
    'id': id,
    'text': text,
    'userId': userId,
    'timestamp': timestamp.toIso8601String(),
  };
}