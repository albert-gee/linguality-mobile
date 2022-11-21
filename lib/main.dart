import 'package:flutter/material.dart';
import 'package:linguality_mobile/providers/article_paragraph_to_speech_provider.dart';
import 'package:linguality_mobile/providers/article_provider.dart';
import 'package:linguality_mobile/providers/bot_provider.dart';
import 'package:linguality_mobile/providers/text_to_speech_provider.dart';
import 'package:linguality_mobile/utils/api/api.dart';
import 'package:linguality_mobile/utils/auth/auth_service.dart';
import 'package:linguality_mobile/utils/auth/auth_service_contract.dart';

import 'liguality_app.dart';

void main() async {

  AuthServiceContract auth = AuthService();
  Api api = Api(auth: auth);

  runApp(LingualityApp(
      authService: AuthService(),
      articleProvider: ArticleProvider(api: api),
      botProvider: BotProvider(api: api),
      textToSpeechProvider: TextToSpeechProvider(api: api),
      articleParagraphToSpeechProvider: ArticleParagraphToSpeechProvider(api: api),
  ));
}


