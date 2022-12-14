part of 'board_bloc.dart';

/// This class describes an abstract event of the board screen.
abstract class BoardEvent extends Equatable {
  const BoardEvent();

  @override
  List<Object> get props => [];
}

/// Load articles from the server
class InitArticlesEvent extends BoardEvent {
  const InitArticlesEvent();

  @override
  List<Object> get props => [];
}

/// Load articles from the server is completed
class InitArticlesCompletedEvent extends BoardEvent {
  const InitArticlesCompletedEvent();

  @override
  List<Object> get props => [];
}

/// Open article
class OpenArticleEvent extends BoardEvent {
  const OpenArticleEvent(this.articleId);

  final String articleId;

  @override
  List<Object> get props => [articleId];
}

/// Close article
class CloseArticleEvent extends BoardEvent {
  const CloseArticleEvent();

  @override
  List<Object> get props => [];
}