import 'package:bot/providers/text_to_speech_provider_contract.dart';

class TextToSpeechRepository {
  final TextToSpeechProviderContract _provider;

  TextToSpeechRepository(TextToSpeechProviderContract provider) : _provider = provider;

  Future<String> convert(String text) => _provider.convert(text);
}