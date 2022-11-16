import 'package:audioplayers/audioplayers.dart';
import 'package:bot/services/text_to_speech/text_to_speech_service_contract.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import '../models/message.dart';

class BotMessageBubbleWidget extends StatelessWidget {
  const BotMessageBubbleWidget(
      {Key? key,
      required this.message,
      required this.isSent,
      required this.isDelivered,
      required this.isSeen,
      required this.textToSpeechService})
      : super(key: key);

  final Message message;
  final TextToSpeechServiceContract textToSpeechService;

  final bool isSent;
  final bool isDelivered;
  final bool isSeen;

  @override
  Widget build(BuildContext context) {
    return Align(
        alignment: (message.userId == 'bot') ? Alignment.topLeft : Alignment.topRight,
        child: _buildSlidableContainer(context));
  }

  Widget _buildSlidableContainer(BuildContext context) {
    return Container(
        margin: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
        width: MediaQuery.of(context).size.width * 0.9,
        child: Slidable(
          // Specify a key if the Slidable is dismissible.
          key: const ValueKey(0),

          // The start action pane is the one at the left or the top side.
          startActionPane: ActionPane(
            // A motion is a widget used to control how the pane animates.
            motion: const ScrollMotion(),

            // A pane can dismiss the Slidable.
            // dismissible: DismissiblePane(onDismissed: () {}),

            // All actions are defined in the children parameter.
            children: [
              // A SlidableAction can have an icon and/or a label.
              SlidableAction(
                onPressed: (context) {
                  textToSpeechService.convert(message.text).then((value) {
                    AudioPlayer audioPlayer = AudioPlayer();
                    audioPlayer.play(DeviceFileSource(value));
                  }).catchError((error) {
                    print(error);
                  });
                },
                backgroundColor: const Color(0xFF21B7CA),
                foregroundColor: Colors.white,
                icon: Icons.record_voice_over,
                label: 'Voice',
              ),
            ],
          ),

          // The child of the Slidable is what the user sees when the
          // component is not dragged.
          child: _buildMessageContainer(),
        ));
  }

  Widget _buildMessageContainer() {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: const Color(0xFFFFFFFF),
        borderRadius: BorderRadius.circular(4),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.25),
            spreadRadius: 2,
            blurRadius: 4,
            offset: const Offset(0, 1), // changes position of shadow
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildTextMessage(),
          const SizedBox(height: 15),
          _buildMessageContainerBottomRow(),
        ],
      ),
    );
  }

  Widget _buildTextMessage() {
    return Text(
      message.text,
      maxLines: 10,
      overflow: TextOverflow.ellipsis,
      style: const TextStyle(
        fontSize: 18,
        color: Color(0xFF3A3A3A),
      ),
    );
  }

  Widget _buildMessageContainerBottomRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: const [
        Text(
          '12:00',
          style: TextStyle(
            color: Color(0xFF97AD8E),
            fontSize: 12,
          ),
        ),
        SizedBox(width: 5),
        Icon(
          Icons.done_all,
          size: 18,
          color: Color(0xFF97AD8E),
        ),
      ],
    );
  }
}
