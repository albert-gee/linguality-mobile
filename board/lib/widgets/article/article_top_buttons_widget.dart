import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/article_listen_bloc/article_listen_bloc.dart';
import '../../bloc/board_bloc/board_bloc.dart';
import '../../models/article.dart';

/// Buttons container is shown below the article title, it has several states.
class ArticleTopButtonsWidget extends StatelessWidget {
  final Article article;
  final ArticleListenBloc articleListenBloc;

  const ArticleTopButtonsWidget(
      {super.key,
      required this.article,
      required this.articleListenBloc});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => articleListenBloc,
      child: BlocBuilder<ArticleListenBloc, ArticleListenState>(
        builder: (context, state) {
          if (state is ArticleListenInitialState) {
            // Article is opened for the first time
            return _buildListenButtonContainer(context, article);
          } else if (state is ArticleListenPlayingState) {
            // Article is playing
            return _buildPauseButtonContainer(context, article);
          } else if (state is ArticleListenPausedState) {
            // Article is paused
            return _buildResumeButtonContainer(context, article);
          } else if (state is ArticleListenCompletedState) {
            // Article listening is completed
            return _buildListenButtonContainer(context, article);
          } else {
            return _buildListenButtonContainer(context, article);
          }
        },
      ),
    );
  }

  /// This method builds the container for the Listen button.
  /// The button may have different states - Listen, Pause, and Resume.
  Widget _buildButtonsContainer(
      {required BuildContext context,
      required String buttonTitle,
      required Color buttonColor,
      required IconData iconData,
      required ArticleListenEvent onTapEvent}) {
    return Container(
      width: double.infinity,
      color: Colors.white,
      margin: const EdgeInsets.only(top: 10),
      padding: const EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          _buildBackButton(context),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              _buildListenButton(
                  context: context,
                  buttonTitle: buttonTitle,
                  iconData: iconData,
                  buttonColor: buttonColor,
                  onTapEvent: onTapEvent),
              const Text('7 min',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.italic,
                    color: Colors.orange,
                  )),
            ],
          )
        ],
      ),
    );
  }

  /// This method builds the Listen button - Listen state
  Widget _buildListenButtonContainer(BuildContext context, Article article) {
    return _buildButtonsContainer(
        context: context,
        buttonTitle: 'Listen',
        buttonColor: Colors.green,
        iconData: Icons.play_circle,
        onTapEvent: ArticleListenPlayPressedEvent(article));
  }

  /// This method builds the Listen button - Pause state
  Widget _buildPauseButtonContainer(BuildContext context, Article article) {
    return _buildButtonsContainer(
        context: context,
        buttonTitle: 'Pause',
        buttonColor: Colors.orange,
        iconData: Icons.pause_circle,
        onTapEvent: const ArticleListenPauseEvent());
  }

  /// This method builds the Listen button - Resume state
  Widget _buildResumeButtonContainer(BuildContext context, Article article) {
    return _buildButtonsContainer(
        context: context,
        buttonTitle: 'Resume',
        buttonColor: Colors.green,
        iconData: Icons.play_circle,
        onTapEvent: const ArticleListenPlayEvent());
  }

  /// Back button
  Widget _buildBackButton(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        BlocProvider.of<BoardBloc>(context).add(const CloseArticleEvent());
      },
    );
  }

  Widget _buildListenButton(
      {required BuildContext context,
      required String buttonTitle,
      required IconData iconData,
      required Color buttonColor,
      required ArticleListenEvent onTapEvent}) {
    return GestureDetector(
      onTap: () async {
        BlocProvider.of<ArticleListenBloc>(context).add(onTapEvent);
        // articleListenBloc.add(onTapEvent);
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 5),
            child: Icon(
              iconData,
              color: buttonColor,
              size: 30,
            ),
          ),
          Text(
            buttonTitle,
            style: TextStyle(
              color: buttonColor,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
