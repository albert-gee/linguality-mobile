part of 'stories_bloc.dart';

/// This class describes an abstract event of the Stories widget.
abstract class StoriesEvent extends Equatable {
  const StoriesEvent();
}

/// Load stories from the server
class StoriesInitEvent extends StoriesEvent {
  const StoriesInitEvent();

  @override
  List<Object> get props => [];
}

/// Stories are loaded from the server
class StoriesInitCompletedEvent extends StoriesEvent {
  const StoriesInitCompletedEvent();

  @override
  List<Object> get props => [];
}

/// Open story
class OpenStoryEvent extends StoriesEvent {
  const OpenStoryEvent(this.storyId);

  final int storyId;

  @override
  List<Object> get props => [storyId];
}

/// Close story
class CloseStoryEvent extends StoriesEvent {
  const CloseStoryEvent();

  @override
  List<Object> get props => [];
}
