import 'package:board/bloc/stories/stories_bloc.dart';
import 'package:board/models/story_cover.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../providers/story_provider_contract.dart';
import '../board/board_loading_widget.dart';

class StoriesWidget extends StatelessWidget {
  final StoryProviderContract storyProvider;
  final StoriesBloc storiesBloc;

  StoriesWidget({Key? key, required this.storyProvider})
    : storiesBloc = StoriesBloc(storyProvider: storyProvider),
      super(key: key);

  @override
  Widget build(BuildContext context) {
    storiesBloc.add(const StoriesInitEvent());
    return _buildBlocProvider();
  }

  Widget _buildBlocProvider() {
    return BlocProvider(
      create: (_) => storiesBloc,
      child: _buildBlocBuilder(),
    );
  }

  Widget _buildBlocBuilder() {
    return BlocBuilder<StoriesBloc, StoriesState>(
      builder: (context, state) {
        if (state is StoriesLoadingState) {
          return const BoardLoadingWidget();
        } else if (state is StoriesLoadedState) {
          return _buildStories(context, state);
        } else {
          return const BoardLoadingWidget();
        }
      },
    );
  }

  Widget _buildStories(BuildContext context, StoriesLoadedState state) {
    return CarouselSlider(
      options: CarouselOptions(
        height: 292,
      ),
      items: state.storyCovers.map((storyCover) {
        return _buildStoryCover(storyCover);
      }).toList(),
    );
  }

  Widget _buildStoryCover(StoryCover storyCover) {
    return Container(
        margin: const EdgeInsets.all(10),
        padding: const EdgeInsets.all(10),
        width: 300,
        height: 280,
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              spreadRadius: 3,
              blurRadius: 7,
              offset: const Offset(0, 3), // changes position of shadow
            ),
          ],
          borderRadius: const BorderRadius.all(Radius.circular(10)),
        ),
        child: Column(
          children: <Widget>[
            _buildArticleCardImage(storyCover.imageUrl, storyCover.id),
            _buildArticleCardTitle(storyCover.title),
          ],
        ));
  }

  Widget _buildArticleCardImage(String imageUrl, int articleId) {
    return GestureDetector(
        onTap: () {
          _tapArticle(articleId);
        },
        child: SizedBox(
          width: 280,
          height: 200,
          child: Image.network(imageUrl, fit: BoxFit.cover),
        ));
  }

  Widget _buildArticleCardTitle(String articleTitle) {
    return Container(
      height: 32,
      margin: const EdgeInsets.only(left: 10, right: 10, top: 10),
      child: Align(
        alignment: Alignment.topLeft,
        child: Text(
          articleTitle,
          maxLines: 2,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.normal,
          ),
        ),
      ),
    );
  }

  void _tapArticle(int storyId) {
    storiesBloc.add(OpenStoryEvent(storyId));
  }
}