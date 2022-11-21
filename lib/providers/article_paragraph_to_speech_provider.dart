import 'dart:io';

import 'package:board/providers/article_paragraph_to_speech_provider_contract.dart';
import 'package:path_provider/path_provider.dart';

import '../configuration/configuration.dart';
import '../utils/api/api.dart';
import '../utils/api/api_response.dart';
import '../utils/key_storage.dart';

class ArticleParagraphToSpeechProvider extends ArticleParagraphToSpeechProviderContract {
  final Configuration settings = Configuration();
  final KeyStorage keyStorage = KeyStorage();
  final Api api;

  ArticleParagraphToSpeechProvider({required this.api});

  @override
  Future<String> convert(String articleId, String paragraphId) async {
    String audioFileName = "$paragraphId.mp3";

    Directory tempDir = await getTemporaryDirectory();
    String tempFilePath = "${tempDir.path}/article_paragraph_audios/$audioFileName";

    if (File(tempFilePath).existsSync()) {
      return tempFilePath;
    } else {
      ApiResponse apiResponse = await api.getDownload(
        url: '${settings.apiServerUrl}/article/$articleId/paragraph/$paragraphId/audio',
        tempFilePath: tempFilePath,
      );

      if (apiResponse.statusCode == 200 && apiResponse.data == tempFilePath) {
        return apiResponse.data;
      } else {
        throw Exception('Unsuccessful text to speech conversion');
      }
    }
  }
}