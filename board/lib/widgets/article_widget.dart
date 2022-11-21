import 'package:board/bloc/article_listen_bloc/article_listen_bloc.dart';
import 'package:board/services/article_paragraph_to_speech/article_paragraph_to_speech_service_contract.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../models/article.dart';

/// This class describes the UI of the article screen.
class ArticleWidget extends StatelessWidget {
  ArticleWidget({super.key, required this.article, required this.articleParagraphToSpeechService})
      : articleListenBloc =
            ArticleListenBloc(articleParagraphToSpeechService: articleParagraphToSpeechService, article: article);

  final Article article;
  final ArticleParagraphToSpeechServiceContract articleParagraphToSpeechService;
  final ArticleListenBloc articleListenBloc;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        controller: ScrollController(),
        child: Container(
          color: Colors.blueGrey[50],
          child: Column(
            children: <Widget>[
              _buildArticleTitle(),
              _buildButtonsContainerBloc(context),
              _buildArticleImage(),
              _buildArticleParagraphs(),
            ],
          ),
        ));
  }

  /// Title of the article is shown at the top of the screen.
  _buildArticleTitle() {
    return Container(
      width: double.infinity,
      color: Colors.white,
      margin: const EdgeInsets.only(top: 10),
      padding: const EdgeInsets.only(left: 10, right: 10, top: 20, bottom: 10),
      child: Text(
        article.title,
        style: const TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.normal,
        ),
      ),
    );
  }

  /// Buttons container is shown below the article title, it has several states.
  _buildButtonsContainerBloc(BuildContext context) {
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
          _buildListenButton(
            context: context,
              buttonTitle: buttonTitle, iconData: iconData, buttonColor: buttonColor, onTapEvent: onTapEvent),
          const Text('7 min read',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                fontStyle: FontStyle.italic,
                color: Colors.orange,
              )),
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
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 5),
            child: Icon(
              iconData,
              color: buttonColor,
              size: 30,
            ),
          ),
          SizedBox(
            width: 70,
            child: Text(
              buttonTitle,
              style: TextStyle(
                color: buttonColor,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Article image is shown below the buttons container.
  _buildArticleImage() {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      child: Image.network(article.imageUrl),
    );
  }

  /// Article paragraphs are shown below the article image.
  Widget _buildArticleParagraphs() {
    return Container(
        width: double.infinity,
        padding: const EdgeInsets.only(bottom: 130),
        child: Column(
          children: article.paragraphs.map((paragraph) {
            return Container(
              color: Colors.white,
              padding: const EdgeInsets.only(left: 10, right: 10, top: 20, bottom: 20),
              margin: const EdgeInsets.only(bottom: 10),
              child: Text(
                paragraph.text,
                style: const TextStyle(
                  fontSize: 21,
                  fontWeight: FontWeight.normal,
                ),
              ),
            );
          }).toList(),
        ));
  }
}
