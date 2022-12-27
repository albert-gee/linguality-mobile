import 'package:board/models/story.dart';
import 'package:board/models/story_cover.dart';
import 'package:board/providers/story_provider_contract.dart';

import '../configuration/configuration.dart';
import '../utils/api/api.dart';
import '../utils/api/api_response.dart';
import '../utils/key_storage.dart';

class StoryProvider extends StoryProviderContract {

  final Configuration settings = Configuration();
  final KeyStorage keyStorage = KeyStorage();
  final Api api;

  StoryProvider({required this.api});

  @override
  Future<List<StoryCover>> fetchStoryCovers() async {
    ApiResponse apiResponse = await api.get(url: '${settings.apiServerUrl}/article');

    if (apiResponse.statusCode == 200) {
      List<StoryCover> storyCovers = (apiResponse.data as List).map((storyCover) => StoryCover.fromJson(storyCover)).toList();

      return storyCovers;
    } else {
      throw Exception('Couldn\'t fetch stories');
    }
  }

  @override
  Future<Story> fetchStory(int storyId) async {
    ApiResponse apiResponse = await api.get(url: '${settings.apiServerUrl}/article/$storyId');

    if (apiResponse.statusCode == 200) {
      return Story.fromJson(apiResponse.data);
    } else {
      throw Exception('Couldn\'t fetch the story');
    }
  }
}