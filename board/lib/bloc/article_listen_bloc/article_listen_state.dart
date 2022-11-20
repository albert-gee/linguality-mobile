part of 'article_listen_bloc.dart';

abstract class ArticleListenState extends Equatable {
  const ArticleListenState();
}

class ArticleListenInitialState extends ArticleListenState {
  final Article article;

  const ArticleListenInitialState({required this.article});

  @override
  List<Object> get props => [];
}

class ArticleListenPlayingState extends ArticleListenState {
  const ArticleListenPlayingState();

  @override
  List<Object> get props => [];
}

class ArticleListenCompletedState extends ArticleListenState {
  const ArticleListenCompletedState();

  @override
  List<Object> get props => [];
}

class ArticleListenPausedState extends ArticleListenState {
  final String articleId;

  const ArticleListenPausedState(this.articleId);

  @override
  List<Object> get props => [articleId];
}

class ArticleListenStoppedState extends ArticleListenState {
  final String articleId;

  const ArticleListenStoppedState(this.articleId);

  @override
  List<Object> get props => [articleId];
}
