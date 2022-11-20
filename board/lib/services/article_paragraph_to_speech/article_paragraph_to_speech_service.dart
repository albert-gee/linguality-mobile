import '../../providers/article_paragraph_to_speech_provider_contract.dart';
import 'article_paragraph_to_speech_service_contract.dart';

class ArticleParagraphToSpeechService extends ArticleParagraphToSpeechServiceContract {
  final ArticleParagraphToSpeechProviderContract _articleParagraphToSpeechProvider;

  ArticleParagraphToSpeechService(ArticleParagraphToSpeechProviderContract textToSpeechProvider)
      : _articleParagraphToSpeechProvider = textToSpeechProvider;

  @override
  Future<String> convert(String articleId, String paragraphId) {
    return _articleParagraphToSpeechProvider.convert(articleId, paragraphId);
  }
}
