import 'package:bot/providers/text_to_speech_provider_contract.dart';
import 'package:bot/repositories/text_to_speech_repository.dart';
import 'package:bot/services/text_to_speech/text_to_speech_service_contract.dart';

class TextToSpeechService extends TextToSpeechServiceContract {
  final TextToSpeechRepository _textToSpeechRepository;

  TextToSpeechService(TextToSpeechProviderContract textToSpeechProvider)
      : _textToSpeechRepository = TextToSpeechRepository(textToSpeechProvider);

  @override
  Future<String> convert(String text) {
    return _textToSpeechRepository.convert(text);
  }
}
