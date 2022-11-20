part of 'board_bloc.dart';

/// This class describes an abstract state of the board screen.
abstract class BoardState {}

/// Initial state of the board screen
class BoardInitialState extends BoardState {}

/// Articles are loaded and displayed on the board screen
class ArticlesLoadedState extends BoardState {
  final List<Article> articles;

  ArticlesLoadedState(this.articles);
}

/// Open article init state
class OpenArticleInitState extends BoardState {}

/// Open article is completed, display it on the board screen
class OpenArticleCompletedState extends BoardState {
  final Article article;
  final ArticleParagraphToSpeechProviderContract articleParagraphToSpeechProvider;

  OpenArticleCompletedState(this.article, this.articleParagraphToSpeechProvider);
}