import 'package:flutter/material.dart';
import 'package:linguality_mobile/providers/bot_provider.dart';
import 'package:linguality_mobile/providers/text_to_speech_provider.dart';

import 'liguality_app.dart';

void main() async {

  runApp(LingualityApp(
      isAuthDisabled: false,
      botProvider: BotProvider(),
      textToSpeechProvider: TextToSpeechProvider(),
  ));
}


