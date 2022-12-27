import '../models/story.dart';
import '../models/story_cover.dart';
import '../providers/story_provider_contract.dart';

class StoryService {
  final StoryProviderContract storyProvider;

  StoryService({required this.storyProvider});

  /// Fetches a list of story covers from the server
  Future<List<StoryCover>> fetchStoryCovers() async {
    return await storyProvider.fetchStoryCovers();
  }

  /// Fetches a story from the server
  Future<Story> fetchStory(int storyId) async {
    return await storyProvider.fetchStory(storyId);
  }
}