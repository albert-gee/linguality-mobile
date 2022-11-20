
import '../providers/article_paragraph_to_speech_provider_contract.dart';

class ArticleParagraphToSpeechRepository {
  final ArticleParagraphToSpeechProviderContract _provider;

  ArticleParagraphToSpeechRepository(ArticleParagraphToSpeechProviderContract provider) : _provider = provider;

  Future<String> convert(String articleId, String paragraphId) => _provider.convert(articleId, paragraphId);
}