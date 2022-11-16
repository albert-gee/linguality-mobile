part of 'board_bloc.dart';

abstract class BoardEvent extends Equatable {}

class InitArticlesEvent extends BoardEvent {
  InitArticlesEvent();

  @override
  List<Object> get props => [];
}

class InitArticlesCompletedEvent extends BoardEvent {
  InitArticlesCompletedEvent();

  @override
  List<Object> get props => [];
}

class OpenArticleEvent extends BoardEvent {
  OpenArticleEvent(this.articleId);

  final String articleId;

  @override
  List<Object> get props => [articleId];
}