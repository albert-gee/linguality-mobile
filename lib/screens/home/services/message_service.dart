import '../models/message.dart';
import '../models/message_type.dart';

class MessageService {

  List<Message> messages = <Message>[];

  MessageService() {
    messages.addAll([
      Message(message: "Hello, how are you?", messageType: MessageType.sender),
      Message(message: "Hello, I'm Linguality!", messageType: MessageType.receiver),
      Message(message: "I am doing fine, what about you?", messageType: MessageType.receiver),
      Message(message: "I'm here to help you learn languages!", messageType: MessageType.sender),
      Message(message: "What language would you like to learn?", messageType: MessageType.receiver),
      Message(message: "Hello, how are you?", messageType: MessageType.sender),
      Message(message: "Hello, I'm Linguality!", messageType: MessageType.receiver),
      Message(message: "I am doing fine, what about you?", messageType: MessageType.receiver),
      Message(message: "I'm here to help you learn languages!", messageType: MessageType.sender),
      Message(message: "What language would you like to learn?", messageType: MessageType.receiver),
      Message(message: "Hello, how are you?", messageType: MessageType.sender),
      Message(message: "Hello, I'm Linguality!", messageType: MessageType.receiver),
      Message(message: "I am doing fine, what about you?", messageType: MessageType.receiver),
      Message(message: "I'm here to help you learn languages!", messageType: MessageType.sender),
      Message(message: "What language would you like to learn?", messageType: MessageType.receiver),
      Message(message: "I'm here to help you learn languages!", messageType: MessageType.sender),
      Message(message: "What language would you like to learn?", messageType: MessageType.receiver),
      Message(message: "Hello, how are you?", messageType: MessageType.sender),
      Message(message: "Hello, I'm Linguality!", messageType: MessageType.receiver),
      Message(message: "I am doing fine, what about you?", messageType: MessageType.receiver),
      Message(message: "I'm here to help you learn languages!", messageType: MessageType.sender),
      Message(message: "What language would you like to learn?", messageType: MessageType.receiver),
    ]);
  }


  void addMessage(Message message) {
    messages.add(message);
  }

  List<Message> getMessages() {
    return messages;
  }


}