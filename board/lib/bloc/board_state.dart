part of 'board_bloc.dart';

@immutable
abstract class BoardState {}

class BoardInitialState extends BoardState {}

class ArticlesLoadedState extends BoardState {
  final List<Article> articles;

  ArticlesLoadedState(this.articles);
}

class OpenArticleInitState extends BoardState {}

class OpenArticleCompletedState extends BoardState {
  final Article article;

  OpenArticleCompletedState(this.article);
}