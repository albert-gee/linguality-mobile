part of 'stories_bloc.dart';

/// This class describes an abstract state of the Stories widget.
abstract class StoriesState extends Equatable {
  const StoriesState();
}

/// Initial state of the Stories widget
class StoriesLoadingState extends StoriesState {
  @override
  List<Object> get props => [];
}

/// Stories are loaded from the server
class StoriesLoadedState extends StoriesState {
  final List<StoryCover> storyCovers;

  const StoriesLoadedState(this.storyCovers);

  @override
  List<Object> get props => [storyCovers];
}

/// Initiate opening of the story
class OpenStoryInitState extends StoriesState {
  @override
  List<Object> get props => [];
}

/// Story is opened
class OpenStoryCompletedState extends StoriesState {
  final Story story;

  const OpenStoryCompletedState(this.story);

  @override
  List<Object> get props => [story];
}
