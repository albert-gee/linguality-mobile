part of 'article_listen_bloc.dart';

abstract class ArticleListenState extends Equatable {
  const ArticleListenState();
}

class ArticleListenInitialState extends ArticleListenState {
  const ArticleListenInitialState();

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
  const ArticleListenPausedState();

  @override
  List<Object> get props => [];
}

class ArticleListenStoppedState extends ArticleListenState {

  const ArticleListenStoppedState();

  @override
  List<Object> get props => [];
}
