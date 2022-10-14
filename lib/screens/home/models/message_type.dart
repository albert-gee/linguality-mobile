class MessageType {
  static const sender = MessageType._('sender');
  static const receiver = MessageType._('receiver');

  static const values = [
    sender,
    receiver,
  ];
  final String value;

  const MessageType._(this.value);

  factory MessageType.fromValue(String value) => values
      .firstWhere((e) => e.value == value, orElse: () => MessageType._(value));

  factory MessageType.fromJson(dynamic data) {
    if (data == null) {
      return const MessageType._('');
    }
    return MessageType.fromValue(data);
  }

  @override
  String toString() => 'MessageType.${value}';

  String toJson() => value;
}