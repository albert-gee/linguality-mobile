import 'package:bot/providers/text_to_speech_provider_contract.dart';

class TestTextToSpeechProvider extends TextToSpeechProviderContract {

  @override
  Future<String> convert(String inputText) async {
    return Future(() => 'test');
  }
}