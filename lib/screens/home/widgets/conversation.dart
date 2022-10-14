

import 'package:chat_bubbles/chat_bubbles.dart';
import 'package:flutter/material.dart';
import 'package:linguality_mobile/screens/home/services/message_service.dart';

import '../models/message.dart';
import '../models/message_type.dart';

class Conversation extends StatefulWidget {
  const Conversation({Key? key}) : super(key: key);

  @override
  State<Conversation> createState() => _ConversationState();
}

class _ConversationState extends State<Conversation> {
  List<Widget> messageWidgets = <Widget>[];

  _ConversationState() {
    List<Message> messages = MessageService().getMessages();

    for (int i = 0; i < messages.length; i++) {
      Message message = messages[i];

      messageWidgets.add(
          BubbleSpecialThree(
            text: i.toString() + message.message,
            color: message.messageType == MessageType.sender ? const Color(
                0xFF1B97F3) : const Color(0xFFECECEC),
            tail: message.messageType == MessageType.receiver,
            isSender: message.messageType == MessageType.sender,
            textStyle: TextStyle(
                color: message.messageType == MessageType.sender
                    ? Colors.white
                    : Colors.black,
                fontSize: 18
            ),
          )
      );
    }

    _addRespondButton();
  }

  _addRespondButton() {
    messageWidgets.add(
      ElevatedButton(
        style: ElevatedButton.styleFrom(
            textStyle: const TextStyle(fontSize: 20)),
        onPressed: () {
          print('pressed');
          setState(() {
            _addInputField();
          });
        },
        child: const Text('Respond'),
      ),
    );
  }

  _addInputField() {
    messageWidgets[messageWidgets.length - 1] = TextField(
      decoration: const InputDecoration(
        border: OutlineInputBorder(),
        labelText: 'Message',
      ),
      autocorrect: false,
      autofocus: true,
      onSubmitted: (String text) async {
        _addMessage(text);


        // send to server
        // // CREATE CLIENT
        // final authorizationEndpoint = Uri.parse('http://127.0.0.1:28080/realms/Linguality/protocol/openid-connect/auth');
        // final tokenEndpoint = Uri.parse('http://127.0.0.1:28080/realms/Linguality/protocol/openid-connect/token');
        // final redirectUrl = Uri.parse('http://127.0.0.1:28080/oauth2-redirect');
        //
        // // The OAuth2 specification expects a client's identifier and secret
        // // to be sent when using the client credentials grant.
        // //
        // // Because the client credentials grant is not inherently associated with a user,
        // // it is up to the server in question whether the returned token allows limited
        // // API access.
        // //
        // // Either way, you must provide both a client identifier and a client secret:
        // const identifier = 'mobile';
        // const secret = 'lAD6Bd7f9vHlaqSBvfvtB0WXiMt0TJVb';
        //
        // // Calling the top-level `clientCredentialsGrant` function will return a
        // // [Client] instead.
        // // try {
        // //   var client = await oauth2.clientCredentialsGrant(authorizationEndpoint, identifier, secret);
        // // } catch (e) {
        // //   print(e);
        // // }
        // var client = await oauth2.clientCredentialsGrant(authorizationEndpoint, identifier, secret);
        //
        //
        // // With an authenticated client, you can make requests, and the `Bearer` token
        // // returned by the server during the client credentials grant will be attached
        // // to any request you make.
        // // var response = await client.post(
        // //     Uri.parse('http://localhost:18888/assistant/respond'),
        // //     body: Message(message: "Hi", messageType: MessageType.sender)
        // // );
        // //
        // // print(response.body);

      },
    );
  }

  _addMessage(String text) {
    setState(() {
      messageWidgets[messageWidgets.length - 1] = BubbleSpecialThree(
        text: text,
        color: const Color(0xFF1B97F3),
        tail: false,
        isSender: true,
        textStyle: const TextStyle(
            color: Colors.white,
            fontSize: 18
        ),
      );

      _addRespondButton();
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: ConstrainedBox(
          constraints: BoxConstraints(
            minHeight: 15,
            maxHeight: MediaQuery
                .of(context)
                .size
                .height - 535,
          ),
          child: ListView.builder(
              reverse: true,
              shrinkWrap: true,
              itemCount: messageWidgets.length,
              itemBuilder: (context, index) =>
              messageWidgets[messageWidgets.length - index - 1]
          ),
        )
    );
  }
}
