import 'dart:io';

import 'package:bot/providers/text_to_speech_provider_contract.dart';
import 'package:path_provider/path_provider.dart';

import '../configuration/configuration.dart';
import '../utils/api/api.dart';
import '../utils/api/api_response.dart';
import '../utils/key_storage.dart';

class TextToSpeechProvider extends TextToSpeechProviderContract {
  final Configuration settings = Configuration();
  final KeyStorage keyStorage = KeyStorage();
  final Api api;

  TextToSpeechProvider({required this.api});

  @override
  Future<String> convert(String inputText) async {
    String audioFileName = "${inputText.hashCode}.mp3";

    Directory tempDir = await getTemporaryDirectory();
    String tempFilePath = "${tempDir.path}/$audioFileName";

    if (File(tempFilePath).existsSync()) {
      return tempFilePath;
    } else {
      ApiResponse apiResponse = await api.postDownload(
        url: '${settings.apiServerUrl}/tts',
        tempFilePath: tempFilePath,
        data: {
          'inputText': inputText,
        },
      );

      if (apiResponse.statusCode == 200 && apiResponse.data == tempFilePath) {
        return apiResponse.data;
      } else {
        throw Exception('Unsuccessful text to speech conversion');
      }
    }
  }
}
