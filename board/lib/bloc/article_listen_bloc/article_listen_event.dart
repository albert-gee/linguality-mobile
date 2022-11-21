part of 'article_listen_bloc.dart';

abstract class ArticleListenEvent extends Equatable {
  const ArticleListenEvent();
}

class ArticleListenPlayPressedEvent extends ArticleListenEvent {
  final Article article;

  const ArticleListenPlayPressedEvent(this.article);

  @override
  List<Object> get props => [article];
}

class ArticleListenPlayEvent extends ArticleListenEvent {
  const ArticleListenPlayEvent();

  @override
  List<Object> get props => [];
}

class ArticleListenPauseEvent extends ArticleListenEvent {
  const ArticleListenPauseEvent();

  @override
  List<Object> get props => [];
}

class ArticleListenCompletedEvent extends ArticleListenEvent {
  const ArticleListenCompletedEvent();

  @override
  List<Object> get props => [];
}

class ArticleListenStopEvent extends ArticleListenEvent {
  const ArticleListenStopEvent();

  @override
  List<Object> get props => [];
}
