import 'package:chat_bubbles/bubbles/bubble_special_three.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/bot_bloc/bot_bloc.dart';
import '../blocs/bot_bloc/bot_event.dart';
import '../blocs/bot_bloc/bot_state.dart';
import '../models/bot.dart';
import '../models/message.dart';
import 'loading_widget.dart';

class BotConversationWidget extends StatelessWidget {
  final BotBloc _botBloc = BotBloc();

  BotConversationWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    _botBloc.add(InitBotEvent());

    return BlocProvider(
      create: (_) => _botBloc,
      child: BlocListener<BotBloc, BotState>(
        listener: (context, state) {
          // TODO: implement listener
          // Open bot panel when message received

          // Show error message when error received
          if (state is BotStateInitError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.error ?? "Error"),
              ),
            );
          }
        },
        child: BlocBuilder<BotBloc, BotState>(
          builder: (context, state) {

            if (state is BotStateInit) {
              return const LoadingWidget();
            } else if (state is BotStateInitResponseReceived) {
              return Column(
                children: [
                  _buildConversation(context, state.bot),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        textStyle: const TextStyle(fontSize: 20)),
                    onPressed: () {
                      print('pressed');
                      _botBloc.add(OpenInputForResponseToBotEvent(state.bot));
                    },
                    child: const Text('Respond'),
                  ),
                ],
              );

              // return _buildConversation(context, state.bot);
            } else if (state is BotStateInitError) {
              return Container();
            } else if (state is BotStateInputOpened) {
              return Column(
                children: [
                  _buildConversation(context, state.bot),
                  _buildInputField(context, state.bot),
                ],
              );
            } else if (state is BotStateMessageSent) {
              return _buildConversation(context, state.bot);
            } else if (state is BotStateMessageResponseReceived) {
              return _buildConversation(context, state.bot);
            } else {
              return Container();
            }

          },
        ),
      ),
    );
  }

  Widget _buildConversation(BuildContext context, Bot bot) {
    return SingleChildScrollView(
      child: ConstrainedBox(
        constraints: BoxConstraints(
          minHeight: 15,
          maxHeight: MediaQuery.of(context).size.height - 535,
        ),
        child: ListView.builder(
          reverse: true,
          shrinkWrap: true,
          itemCount: bot.messages.length,
          itemBuilder: (context, index) {
            // Message message = bot.messages[bot.messages.length - index - 1];
            //
            // return BubbleSpecialThree(
            //   text: message.text,
            //   color: message.messageType == MessageType.bot ? const Color(0xFF1B97F3) : const Color(0xFFECECEC),
            //   tail: message.messageType == MessageType.bot,
            //   isSender: message.messageType == MessageType.bot,
            //   textStyle: TextStyle(
            //       color: message.messageType == MessageType.bot
            //           ? Colors.white
            //           : Colors.black,
            //       fontSize: 18
            //   ),
            // );
            Message message = bot.messages[bot.messages.length - index - 1];

            return BubbleSpecialThree(
              text: message.text,
              color: const Color(0xFF1B97F3),
              tail: true,
              isSender: true,
              textStyle: const TextStyle(color: Colors.black, fontSize: 18),
            );
          },
        ),
      ),
    );
  }

  Widget _buildInputField(BuildContext context, Bot bot) {
    return TextField(
      decoration: const InputDecoration(
        border: OutlineInputBorder(),
        labelText: 'Message',
      ),
      autocorrect: false,
      autofocus: true,
      onSubmitted: (String text) async {
        // _addMessage(text);


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
        // //     body: Message(message: "Hi", messageType: MessageType.bot)
        // // );
        // //
        // // print(response.body);

      },
    );
  }
}
