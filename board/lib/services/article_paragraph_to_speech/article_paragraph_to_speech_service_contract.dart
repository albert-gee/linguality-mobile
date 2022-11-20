abstract class ArticleParagraphToSpeechServiceContract {
  /// Convert text to speech and return a link to the audio file
  Future<String> convert(String articleId, String paragraphId);
}