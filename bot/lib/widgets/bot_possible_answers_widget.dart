import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import '../models/possible_answer.dart';
import '../services/text_to_speech/text_to_speech_service_contract.dart';

class BotPossibleAnswersWidget extends StatelessWidget {
  const BotPossibleAnswersWidget({super.key, required this.possibleAnswers, required this.textEditingController, required this.textToSpeechService});

  final TextToSpeechServiceContract textToSpeechService;
  final TextEditingController textEditingController;
  final Set<PossibleAnswer> possibleAnswers;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topRight,
      child: Container(
        margin: const EdgeInsets.only(right: 10, top: 10, bottom: 20),
        width: MediaQuery.of(context).size.width * 0.9,
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.3),
                spreadRadius: 2,
                blurRadius: 4,
                offset: const Offset(0, 1), // changes position of shadow
              ),
            ],
          ),
          child: ListView.builder(
            reverse: true,
            shrinkWrap: true,
            itemCount: possibleAnswers.length,
            scrollDirection: Axis.vertical,
            itemBuilder: (context, index) {
              final possibleAnswer = possibleAnswers.elementAt(index);
              return _buildSlidableContainer(context, possibleAnswer.text);
            },
          )
      ),
    );
  }

  Widget _buildSlidableContainer(BuildContext context, String possibleAnswer) {
    return Slidable(
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
              textToSpeechService.convert(possibleAnswer).then((value) {
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
      child: GestureDetector(
        onTap: () {
          textEditingController.text = possibleAnswer;
        },
        child: Container(
          color: Colors.blue,
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.all(20),
          margin: const EdgeInsets.only(bottom: 1),
          child: Text(possibleAnswer, style: const TextStyle(color: Colors.white), textAlign: TextAlign.center,),
        ),
      ),
    );
  }
}