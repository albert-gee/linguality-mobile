part of 'board_bloc.dart';

/// This class describes an abstract event of the board screen.
abstract class BoardEvent extends Equatable {}

/// Load articles from the server
class InitArticlesEvent extends BoardEvent {
  InitArticlesEvent();

  @override
  List<Object> get props => [];
}

/// Load articles from the server is completed
class InitArticlesCompletedEvent extends BoardEvent {
  InitArticlesCompletedEvent();

  @override
  List<Object> get props => [];
}

/// Open article
class OpenArticleEvent extends BoardEvent {
  OpenArticleEvent(this.articleId);

  final String articleId;

  @override
  List<Object> get props => [articleId];
}