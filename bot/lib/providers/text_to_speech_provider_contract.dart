abstract class TextToSpeechProviderContract {
  /// Convert text to speech and return a location of the audio file
  Future<String> convert(String inputText);
}