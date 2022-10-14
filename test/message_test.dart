import 'package:linguality_mobile/screens/home/models/message.dart';
import 'package:linguality_mobile/screens/home/models/message_type.dart';
import 'package:linguality_mobile/screens/home/services/message_service.dart';
import 'package:test/test.dart';

void main() {
  test('Message length should be positive', () {
    final message = Message(message: "Test", messageType: MessageType.sender);
    expect(message.message.length, greaterThan(0));
  });

  test('Message length shouldn\'t be greater than 35', () {
    final message = Message(message: "Test", messageType: MessageType.sender);
    expect(message.message.length, lessThan(35));
  });

  test('Messages list size should increment after adding a new message', () {
    final messageService = MessageService();
    int initialSize = messageService.messages.length;
    final message = Message(message: "Test", messageType: MessageType.sender);
    messageService.addMessage(message);

    expect(initialSize, equals(messageService.messages.length - 1));
  });
}