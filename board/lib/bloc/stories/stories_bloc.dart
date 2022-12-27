import 'package:bloc/bloc.dart';
import 'package:board/providers/story_provider_contract.dart';
import 'package:equatable/equatable.dart';

import '../../models/story.dart';
import '../../models/story_cover.dart';

part 'stories_event.dart';
part 'stories_state.dart';

/// This class describes the business logic of the Stories widget.
class StoriesBloc extends Bloc<StoriesEvent, StoriesState> {

  final StoryProviderContract storyProvider;

  StoriesBloc({required this.storyProvider}) : super(StoriesLoadingState()) {

    /// Load stories from the server and emit StoriesLoadedState
    on<StoriesInitEvent>((event, emit) async {
      emit(StoriesLoadingState());
      final List<StoryCover> storyCovers = await storyProvider.fetchStoryCovers();
      emit(StoriesLoadedState(storyCovers));
    });

    on<StoriesInitCompletedEvent>((event, emit) async {});

    /// Initiate opening of the story
    on<OpenStoryEvent>((event, emit) async {
      emit(OpenStoryInitState());
      final Story story = await storyProvider.fetchStory(event.storyId);
      emit(OpenStoryCompletedState(story));
    });

    on<CloseStoryEvent>((event, emit) async {});
  }
}
