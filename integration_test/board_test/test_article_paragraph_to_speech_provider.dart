import 'package:board/providers/article_paragraph_to_speech_provider_contract.dart';

class TestArticleParagraphToSpeechProvider extends ArticleParagraphToSpeechProviderContract {

  @override
  Future<String> convert(String articleId, String paragraphId) {
    // ToDo implement
    return Future.value('https://www.soundhelix.com/examples/mp3/SoundHelix-Song-1.mp3');
  }
}