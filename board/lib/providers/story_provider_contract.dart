import '../models/story.dart';
import '../models/story_cover.dart';

abstract class StoryProviderContract {
  Future<List<StoryCover>> fetchStoryCovers();
  Future<Story> fetchStory(int storyId);
}